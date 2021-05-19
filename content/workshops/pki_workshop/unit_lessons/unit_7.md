# Unit 7. Recovering a certificate

In this unit we will simulate recovering a user's private key.

## Recover Private Key

The URL is different in the images. I'm lazy.

1. In new tab, open KRA webpage.

    `https://ca1.redhat.example.com:8443/kra/agent/kra`

2. Select `PKI Administrator` certificate (if prompted).

3. Add Exception for insecure connection (if prompted).

4. Click `Search for Keys`.

       ![Alt text](images/keyrecover_lab_1.png)

5. Check `Key Identifiers` box and click `Show Key` (scroll down).

       ![Alt text](images/keyrecover_lab_2.png)

6. Click `Details` button.

       ![Alt text](images/keyrecover_lab_3.png)

7. Details of key.

       ![Alt text](images/keyrecover_lab_4.png)

8. Click `Recover Keys`.

       ![Alt text](images/keyrecover_lab_5.png)

9. Check `Key Identifiers` box and click `Show Key` (scroll down).

       ![Alt text](images/keyrecover_lab_6.png)

10. Click `Recover` button.

       ![Alt text](images/keyrecover_lab_7.png)

11. Open new tab.

    `https://ca1.redhat.example.com:8443/ca/agent/ca`

12. Click `List Certificates`.

       ![Alt text](images/keyrecover_lab_8.png)
   
13. Click `Find` button.

       ![Alt text](images/keyrecover_lab_9.png)

14. Click certificate with `UID=`.

       ![Alt text](images/keyrecover_lab_10.png)

15. Scroll down to `Base 64 encoded certificate`.

       ![Alt text](images/keyrecover_lab_11.png)

16. Copy entire certificate into buffer. Include `-----BEGIN` and `-----END` lines.    

17. Go back to KRA tab.

18. Paste into `Certificate` box.

       ![Alt text](images/keyrecover_lab_12.png)

19. Click `Recover` button.

       ![Alt text](images/keyrecover_lab_13.png)

20. Click request number.

       ![Alt text](images/keyrecover_lab_14.png)

21. Click `Grant` link.

       ![Alt text](images/keyrecover_lab_15.png)

22. Click request number.

       ![Alt text](images/keyrecover_lab_16.png)

23. Enter `redhat` in both password fields.

       ![Alt text](images/keyrecover_lab_17.png)

24. Click `Retrieve PKCS#12`.

       ![Alt text](images/keyrecover_lab_18.png)

25. Save file somewhere.

26. View recovered key.

    `openssl pkcs12 -in getAsyncPk12`

        Enter Import Password: redhat
        MAC verified OK
        Bag Attributes
            localKeyID: F3 BA E7 AA FC 9C 4B 86 3D 11 9F 4A 3F 02 C1 6A A2 AE 37 70 
            friendlyName: UID=brian-test
        Key Attributes: <No Attributes>
        Enter PEM pass phrase: redhat
        Verifying - Enter PEM pass phrase: redhat

The next lesson is [Unit 8: Revoking a certificate](https://gitlab.consulting.redhat.com/pki/pki-workshop/blob/master/unit_lessons/unit_8.md).
