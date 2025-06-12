import { GoogleLogo } from "phosphor-react-native";
import { StyleSheet, Text, TouchableOpacity } from "react-native";
import * as Google from "expo-auth-session/providers/google";
import * as WebBrowser from "expo-web-browser";
import * as AuthSession from "expo-auth-session";
import { useEffect } from "react";

WebBrowser.maybeCompleteAuthSession();

const LoginWithGoogle = () => {
  const [request, response, loginUi] = Google.useAuthRequest({
    expoClientId:
      "239705382237-trblpmqaad9j3kagcdir7j7d5va5s3as.apps.googleusercontent.com",
    androidClientId:
      "239705382237-i2euf704064a6vc4k2shpim9f1dt4m88.apps.googleusercontent.com",
    redirectUri: AuthSession.makeRedirectUri({
      useProxy: true,
    }),
    scopes: ["profile", "email"],
  });

  useEffect(() => {
    if (response?.type === "success") {
      const { id_token } = response.authentication;
      console.log(id_token);
      //   handleGoogleLogin(id_token);
    }
  }, [response]);

  return (
    <TouchableOpacity style={styles.googleButton} onPress={() => loginUi()}>
      <GoogleLogo size={20} color="#EA4335" style={{ marginRight: 8 }} />
      <Text style={styles.googleButtonText}>Tiếp tục với Google</Text>
    </TouchableOpacity>
  );
};

export default LoginWithGoogle;

const styles = StyleSheet.create({
  googleButton: {
    flexDirection: "row",
    borderColor: "#EA4335",
    borderWidth: 1.2,
    paddingVertical: 10,
    borderRadius: 8,
    justifyContent: "center",
    alignItems: "center",
  },
  googleButtonText: {
    color: "#EA4335",
    fontWeight: "600",
    fontSize: 15,
  },
});
