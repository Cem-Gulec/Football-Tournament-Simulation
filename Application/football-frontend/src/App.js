import "./App.css";
import DenseAppBar from "./components/DenseAppBar/DenseAppBar";
import Footer from "./components/Footer/Footer";

import { BrowserRouter as Router, Route, Switch } from "react-router-dom";

import Home from "./Pages/Home";
import Awards from "./Pages/Awards";
import Goal from "./Pages/Goal";
import Manager from "./Pages/Manager";
import Match from "./Pages/Match";
import Pitch from "./Pages/Pitch";
import Player from "./Pages/Player";
import PlayerPosition from "./Pages/PlayerPosition";
import Referee from "./Pages/Referee";
import Team from "./Pages/Team";
import Tournament from "./Pages/Tournament";
import TournamentTeam from "./Pages/TournamentTeam";
import ContactUs from "./Pages/ContactUs";

function App() {
  return (
    <Router>
      <DenseAppBar></DenseAppBar>
      <Switch>
        <Route path="/" exact component={Home}></Route>
        <Route path="/awards" component={Awards}></Route>
        <Route path="/goal" component={Goal}></Route>
        <Route path="/manager" component={Manager}></Route>
        <Route path="/match" component={Match}></Route>
        <Route path="/pitch" component={Pitch}></Route>
        <Route path="/player" component={Player}></Route>
        <Route path="/playerPosition" component={PlayerPosition}></Route>
        <Route path="/referee" component={Referee}></Route>
        <Route path="/team" component={Team}></Route>
        <Route path="/tournament" component={Tournament}></Route>
        <Route path="/tournamentTeam" component={TournamentTeam}></Route>
        <Route path="/contactUs" component={ContactUs}></Route>
      </Switch>
      <Footer></Footer>
    </Router>
  );
}

export default App;
