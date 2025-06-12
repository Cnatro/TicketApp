import { Icon } from "react-native-paper";
import { createBottomTabNavigator } from "@react-navigation/bottom-tabs";
import { NavigationContainer } from "@react-navigation/native";
import Home from "./components/Home/Home";
import EventDetail from "./components/Home/EventDetail";
import { createStackNavigator } from "@react-navigation/stack";
import UserHome from "./components/User/UserHome";
import EventCategory from "./components/Home/EventCategory";
import { useEffect, useReducer } from "react";
import UserReducer from "./reducers/UserReducer";
import { DispatcherUserContext, UserContext } from "./contexts/MyContext";
import Login from "./components/User/Login";
import useAuth from "./Hooks/useAuth";
import Register from "./components/User/Register";
import Ticket from "./components/Home/Ticket";
import Receipted from "./components/Home/Receipted";
import PayPal from "./components/Payment/PayPal";
import ChatBox from "./components/Home/ChatBox";
// import { requestPermissionNotification, sheduleNoticationsForTickets } from "./components/Home/Notifications";

const Tab = createBottomTabNavigator();
const Stack = createStackNavigator();

const HomeStack = () => {
  const [userData] = useAuth();
  const user = userData?._j || null;
  return (
    <Stack.Navigator>
      <Stack.Screen
        name="Home"
        component={Home}
        options={{ headerShown: false }}
      />
      <Stack.Screen
        name="EventDetail"
        component={EventDetail}
        options={{ title: "Chi tiết sự kiện" }}
      />
      <Stack.Screen name="EventCategory" component={EventCategory} />
      <Stack.Screen
        name="Ticket"
        component={Ticket}
        options={{ title: "Đặt vé" }}
      />
      <Stack.Screen
        name="PayPal"
        component={PayPal}
        options={{ title: "Thanh toán" }}
      />
      <Stack.Screen
        name="ChatBox"
        component={ChatBox}
        options={{ title: "Tin nhắn" }}
      />
    </Stack.Navigator>
  );
};

const UserStack = () => {
  const [userData] = useAuth();
  const user = userData?._j || null;
  return (
    <Stack.Navigator>
      <Stack.Screen
        name="UserHome"
        component={UserHome}
        options={{ headerShown: false }}
      />
      <Stack.Screen
        name="Receipted"
        component={Receipted}
        options={{ title: "Vé đã mua" }}
      />
      {user === null && (
        <>
          <Stack.Screen
            name="Login"
            component={Login}
            options={{
              headerTitle: "",
              headerShadowVisible: false,
              headerBackTitleVisible: false,
              headerStyle: {
                backgroundColor: "transparent",
                elevation: 0,
                shadowOpacity: 0,
              },
            }}
          />
          <Stack.Screen
            name="Register"
            component={Register}
            options={{
              headerTitle: "",
              headerShadowVisible: false,
              headerBackTitleVisible: false,
              headerStyle: {
                backgroundColor: "transparent",
                elevation: 0,
                shadowOpacity: 0,
              },
            }}
          />
        </>
      )}
    </Stack.Navigator>
  );
};

const TabNavigator = () => {
  return (
    <Tab.Navigator
      screenOptions={{
        tabBarShowLabel: false,
        headerShown: false,
      }}
    >
      <Tab.Screen
        name="HomeStack"
        component={HomeStack}
        options={{
          tabBarIcon: ({ color, size }) => (
            <Icon source="home" color={color} size={size} />
          ),
        }}
      />
      <Tab.Screen
        name="UserStack"
        component={UserStack}
        options={{
          tabBarIcon: ({ color, size }) => (
            <Icon source="account" color={color} size={size} />
          ),
        }}
      />
    </Tab.Navigator>
  );
};
const App = () => {
  const [user, dispatch] = useReducer(UserReducer, null);

  // const loadNotification = async () =>{
  //   await requestPermissionNotification();
  //   await sheduleNoticationsForTickets();
  // }
  // useEffect(() => {
  //   loadNotification();
  // }, []);
  return (
    <UserContext.Provider value={user}>
      <DispatcherUserContext.Provider value={dispatch}>
        <NavigationContainer>
          <TabNavigator />
        </NavigationContainer>
      </DispatcherUserContext.Provider>
    </UserContext.Provider>
  );
};
export default App;
