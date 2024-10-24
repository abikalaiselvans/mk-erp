package com.my.org.erp.security;
import java.io.*; 

import java.security.spec.*; 
import javax.crypto.*; 
import javax.crypto.spec.*; 

public class DesEncrypter  
{  
        Cipher ecipher; 
        Cipher dcipher; 

        DesEncrypter ( SecretKey key )   
        {  
            // Create an 8-byte initialization vector 
            byte [  ]  iv = new byte [  ] {( byte ) 0x8E, 0x12, 0x39,  ( byte ) 0x9C, 0x07, 0x72, 0x6F, 0x5A } ; 
            AlgorithmParameterSpec paramSpec = new IvParameterSpec ( iv ) ; 
            try  
            {  
                ecipher = Cipher.getInstance ( "DES/CBC/PKCS5Padding" ) ; 
                dcipher = Cipher.getInstance ( "DES/CBC/PKCS5Padding" ) ; 
                ecipher.init ( Cipher.ENCRYPT_MODE, key, paramSpec ) ; 
                dcipher.init ( Cipher.DECRYPT_MODE, key, paramSpec ) ; 
             }  
            catch  ( java.security.InvalidAlgorithmParameterException e ){}   
            catch  ( javax.crypto.NoSuchPaddingException e )   {}  
            catch  ( java.security.NoSuchAlgorithmException e )   { }  
            catch  ( java.security.InvalidKeyException e )   {  }  
         }  
 
 
        // Buffer used to transport the bytes from one stream to another 
        byte [  ]  buf = new byte [ 1024 ] ; 
 
 
        public void encrypt ( InputStream in, OutputStream out )   {  
            try  {  
                // Bytes written to out will be encrypted 
                out = new CipherOutputStream ( out, ecipher ) ; 
 
 
                // Read in the cleartext bytes and write to out to encrypt 
                int numRead = 0; 
                while  (( numRead = in.read( buf ) ) >= 0 )   {  
                    out.write ( buf, 0, numRead ) ; 
                 }  
                System.out.println ( "encrypt" ) ; 
                out.close (  ) ; 
             }  catch  ( java.io.IOException e )   {  
        System.out.println ( "Exception e in encrypt="+e ) ; 
             }  
         }  
 
 
        public void decrypt ( InputStream in, OutputStream out )   {  
            try  {  
                // Bytes read from in will be decrypted 
                in = new CipherInputStream ( in, dcipher ) ; 
 
 
                // Read in the decrypted bytes and write the cleartext to out 
                int numRead = 0; 
                while  (  ( numRead = in.read ( buf )  )   >= 0 )   {  
                    out.write ( buf, 0, numRead ) ; 
                 }  
                out.close (  ) ; 
             }  catch  ( java.io.IOException e )   {  
        System.out.println ( "Exception e in decrypt="+e ) ; 
             }  
         }  
        public static void main ( String args [  ]  )  
         {  
      System.out.println ( "hello" ) ; 
        try  {  
        // Generate a temporary key. In practice, you would save this key. 
        // See also e464 Encrypting with DES Using a Pass Phrase. 
        SecretKey key = KeyGenerator.getInstance ( "DES" ) .generateKey (  ) ; 
        System.out.println ( "1111" ) ; 
        // Create encrypter/decrypter class 
        DesEncrypter encrypter = new DesEncrypter ( key ) ; 
        System.out.println ( "2222" ) ; 
        // Encrypt 
        encrypter.encrypt ( new FileInputStream ( "c:\text1.txt" ) , 
          new FileOutputStream ( "c:\text2" )  ) ; 
        System.out.println ( "3333" ) ; 
        // Decrypt 
        encrypter.decrypt ( new FileInputStream ( "c:\text2.txt" ) , 
          new FileOutputStream ( "c:\text12" )  ) ; 
        System.out.println ( "4444" ) ; 
       }  catch  ( Exception e )   {  
        System.out.println ( "Exception e="+e ) ; 
        
        @SuppressWarnings("unused")
		double d=Math.PI;
       }  
 
 
 
     }  
     }  
 