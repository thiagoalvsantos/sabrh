package br.pucpr.sabrh.common.utils;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

import sun.misc.BASE64Encoder;

public class CriptografiaUtil {
	
	public static String criptografar(String senha) {
        try {
                MessageDigest digest = MessageDigest.getInstance("MD5");
                digest.update(senha.getBytes());
                BASE64Encoder encoder = new BASE64Encoder();
                return encoder.encode(digest.digest());
        } catch (NoSuchAlgorithmException ns) {
                ns.printStackTrace();
                return senha;
        }
	}
	
	public static boolean isEqual(byte[] criptografia1, byte[] criptografia2) {
        if (criptografia1.length != criptografia2.length)
                return false;
        int index;
        for (index = 0; index < criptografia1.length; index++) {
                if (criptografia1[index] != criptografia2[index])
                        break;
        }
        return index == criptografia2.length;
	}

}
