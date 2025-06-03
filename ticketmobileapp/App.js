import { Icon } from "react-native-paper";
import { createBottomTabNavigator } from "@react-navigation/bottom-tabs";
import { NavigationContainer } from "@react-navigation/native";
import Home from "./components/Home/Home";
import EventDetail from "./components/Home/EventDetail";
import { createStackNavigator } from "@react-navigation/stack";
import UserHome from "./components/User/UserHome";
import EventCategory from "./components/Home/EventCategory";

const Tab = createBottomTabNavigator();
const Stack = createStackNavigator();

const HomeStack = () => {
  return (
    <Stack.Navigator>
      <Stack.Screen
        name="Home"
        component={Home}
        options={{ title: "Trang chủ", headerShown: false }}
      />
      <Stack.Screen
        name="EventDetail"
        component={EventDetail}
        options={{ title: "Chi tiết sự kiện" }}
      />
      <Stack.Screen
        name="EventCategory"
        component={EventCategory}
      />
    </Stack.Navigator>
  );
};
const TabNavigator = () => {
  return (
    <Tab.Navigator>
      <Tab.Screen
        name="HomeStack"
        component={HomeStack}
        options={{
          title: "Trang chủ",
          tabBarShowLabel: false,
          tabBarIcon: () => <Icon size={30} source="home-circle" />,
          headerShown: false,
        }}
      />
      <Tab.Screen
        name="UserHome"
        component={UserHome}
        options={{
          title: "Người dùng",
          tabBarShowLabel: false,
          tabBarIcon: () => <Icon size={30} source="account" />,
          headerShown: false,
        }}
      />
    </Tab.Navigator>
  );
};

const App = () => {
  return (
    <NavigationContainer>
      <TabNavigator />
    </NavigationContainer>
  );
};
export default App;
