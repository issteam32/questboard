package com.questboard.user;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

import javax.net.ssl.*;
import java.security.KeyManagementException;
import java.security.NoSuchAlgorithmException;
import java.security.cert.X509Certificate;

@SpringBootApplication
public class UserApplication {

	public static void main(String[] args) {
		/*
		 *  fix for
		 *    Exception in thread "main" javax.net.ssl.SSLHandshakeException:
		 *       sun.security.validator.ValidatorException:
		 *           PKIX path building failed: sun.security.provider.certpath.SunCertPathBuilderException:
		 *               unable to find valid certification path to requested target
		 */
		try {
			TrustManager[] trustAllCerts = new TrustManager[]{
					new X509TrustManager() {
						public java.security.cert.X509Certificate[] getAcceptedIssuers() {
							return null;
						}

						public void checkClientTrusted(X509Certificate[] certs, String authType) {
						}

						public void checkServerTrusted(X509Certificate[] certs, String authType) {
						}

					}
			};

			SSLContext sc = SSLContext.getInstance("SSL");
			sc.init(null, trustAllCerts, new java.security.SecureRandom());
			HttpsURLConnection.setDefaultSSLSocketFactory(sc.getSocketFactory());

			// Create all-trusting host name verifier
			HostnameVerifier allHostsValid = new HostnameVerifier() {
				public boolean verify(String hostname, SSLSession session) {
					return true;
				}
			};
			// Install the all-trusting host verifier
			HttpsURLConnection.setDefaultHostnameVerifier(allHostsValid);
			/*
			 * end of the fix
			 */
		} catch (NoSuchAlgorithmException noSuchAlgorithmException) {
			System.out.println("#################################");
			System.out.println("No such algorithm error");
			System.out.println("#################################");
		} catch (KeyManagementException keyManagementException) {
			System.out.println("#################################");
			System.out.println("key management error");
			System.out.println("#################################");
		}
		SpringApplication.run(UserApplication.class, args);
	}

}
