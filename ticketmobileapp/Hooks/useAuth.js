import { useContext } from "react";
import { DispatcherUserContext, UserContext } from "../contexts/MyContext";

const useAuth = () => {
  const user = useContext(UserContext);
  const dispatch = useContext(DispatcherUserContext);

  const login = (userData) => {
    dispatch({
      type: "login",
      payload: userData,
    });
  };

  const auth = {
    login: (userData) => login(userData),
    logout: () => dispatch({ type: "logout" }),
  };

  return [user, auth];
};
export default useAuth;
