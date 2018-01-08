#!/usr/bin/env python

from __future__ import print_function

import glob
import hashlib

import httplib2
import os
import re

from dateutil.parser import parse
from apiclient import discovery
from jinja2 import Template
from oauth2client import client
from oauth2client import tools
from oauth2client.file import Storage
from slugify import slugify

SCOPES = 'https://www.googleapis.com/auth/spreadsheets.readonly'
CLIENT_SECRET_FILE = 'client_secret.json'
APPLICATION_NAME = 'RedHatGov.io Events Import'

BASE_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
EVENTS_CONTENT_DIR = os.path.join(BASE_DIR, 'content', 'events')


class Event(object):
    def __init__(self, start_date, end_date, start_time, end_time, title,
                 location, technology, event_type, link):
        self._start_date = ''
        self._end_date = ''
        self._start_time = ''
        self._end_time = ''

        self.start_date = start_date
        self.end_date = end_date
        self.start_time = start_time
        self.end_time = end_time
        self.title = title.strip()
        self.location = location.strip()
        self.technology = technology
        self.event_type = event_type
        self.link = link

        if not self.end_date:
            self.end_date = self.start_date

    def __repr__(self):
        return '<Event: {}>'.format(self.title)

    @classmethod
    def from_sheets_row(cls, row):
        def row_value(row_data, index):
            if index > len(row_data)-1:
                return ''
            return row_data[index]

        return Event(
            start_date=row_value(row, 0),
            end_date=row_value(row, 1),
            start_time=row_value(row, 2),
            end_time=row_value(row, 3),
            title=row_value(row, 4),
            location=row_value(row, 5),
            technology=row_value(row, 6),
            event_type=row_value(row, 7),
            link=row_value(row, 8),
        )

    @property
    def start_date(self):
        return self._start_date

    @start_date.setter
    def start_date(self, value):
        if not value:
            return
        try:
            self._start_date = parse(value)
        except ValueError:
            pass  # TODO: handle exception

    @property
    def end_date(self):
        return self._end_date

    @end_date.setter
    def end_date(self, value):
        if not value:
            return
        try:
            self._end_date = parse(value)
        except ValueError:
            pass  # TODO: handle exception

    @property
    def start_time(self):
        return self._start_time

    @start_time.setter
    def start_time(self, value):
        if not value:
            return
        try:
            self._start_time = parse(value)
        except ValueError:
            pass  # TODO: handle exception

    @property
    def end_time(self):
        return self._end_time

    @end_time.setter
    def end_time(self, value):
        if not value:
            return
        try:
            self._end_time = parse(value)
        except ValueError:
            pass  # TODO: handle exception

    @property
    def hash(self):
        m = hashlib.md5()
        m.update(str(self.start_date))
        m.update(str(self.end_date))
        m.update(self.title)
        m.update(self.location)
        return m.hexdigest()

    def filename(self):
        if not self.start_date:
            raise ValueError('This event does not have a start date')
        if len(self.title) == 0:
            raise ValueError('This event does not have a title')
        return '{}-{}-{}.md'.format(
            self.start_date.strftime('%Y%m%d'),
            slugify(self.title, to_lower=True)[:100],
            self.hash,
        )


def get_credentials():
    """Gets valid user credentials from storage.

    If nothing has been stored, or if the stored credentials are invalid,
    the OAuth2 flow is completed to obtain the new credentials.

    Returns:
        Credentials, the obtained credential.
    """
    credential_dir = os.path.dirname(os.path.realpath(CLIENT_SECRET_FILE))
    credential_path = os.path.join(
        credential_dir, 'sheets.googleapis.com-redhatgov-events.json')

    store = Storage(credential_path)
    credentials = store.get()
    if not credentials or credentials.invalid:
        flow = client.flow_from_clientsecrets(CLIENT_SECRET_FILE, SCOPES)
        flow.user_agent = APPLICATION_NAME
        credentials = tools.run_flow(flow, store)
        print('Storing credentials to ' + credential_path)
    return credentials


def main():
    """Shows basic usage of the Sheets API.

    Creates a Sheets API service object and prints the names and majors of
    students in a sample spreadsheet:
    https://docs.google.com/spreadsheets/d/1BxiMVs0XRA5nFMdKvBdBZjgmUUqptlbs74OgvE2upms/edit
    """
    credentials = get_credentials()
    http = credentials.authorize(httplib2.Http())
    discovery_url = 'https://sheets.googleapis.com/$discovery/rest?version=v4'
    service = discovery.build('sheets', 'v4', http=http,
                              discoveryServiceUrl=discovery_url)

    spreadsheet_id = '1XAdmKviBgA69S18cxQhjbdd0M3ehLnUUaRNTwoYmcKk'
    range_name = 'Events!A2:I'
    result = service.spreadsheets().values().get(
        spreadsheetId=spreadsheet_id, range=range_name).execute()
    values = result.get('values', [])

    if not values:
        print('No data found.')
        return

    events = {}
    for row in values:
        event = Event.from_sheets_row(row)
        events[event.hash] = event

    event_files = {}
    for event_file in os.listdir(EVENTS_CONTENT_DIR):
        if event_file == '_index.md':
            continue  # Skip the main page
        if len(event_file) < 45 or event_file[-3:] != '.md':
            continue  # Skip files that don't appear to be auto-generated

        match = re.match(r'\d{8}-\S+-(\S+).md', event_file)
        if not match:
            # TODO: log mismatch
            continue
        event_files[match.group(1)] = event_file

    for event_hash, event in events.iteritems():
        if event_hash in event_files:
            print('SKIPPING', event)
            continue  # Skip event files that already exist
        print('creating', event)
        full_filename = os.path.join(EVENTS_CONTENT_DIR, event.filename())
        with open(full_filename, 'w') as f:
            template = Template(
                '---\n'
                'title: "{{ title }}"\n'
                'date: "{{ start_date }}"\n'
                'expiryDate: "{{ end_date }}"\n'
                '\n'
                'event_start_date: "{{ start_date }}"\n'
                'event_end_date: "{{ end_date }}"\n'
                'event_start_time: "{{ start_time }}"\n'
                'event_end_time: "{{ end_time }}"\n'
                'event_location: "{{ location }}"\n'
                'event_link: "{{ link }}"\n'
                '\n'
                'event_type: "{{ event_type }}"\n'
                'event_technology: "{{ technology }}"\n'
                '---\n'
            )
            content = template.render(
                title=event.title,
                start_date=event.start_date.strftime('%Y-%m-%d'),
                end_date=event.end_date.strftime('%Y-%m-%d'),
                start_time=event.start_time.strftime('%I:%M %p') if event.start_time else '',
                end_time=event.end_time.strftime('%I:%M %p') if event.end_time else '',
                location=event.location,
                link=event.link,
                event_type=event.event_type,
                technology=event.technology,
            )
            f.write(content)


if __name__ == '__main__':
    main()
