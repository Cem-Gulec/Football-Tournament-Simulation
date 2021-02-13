import React from "react";
import { DataGrid } from "@material-ui/data-grid";
import axios from "axios";

export default function Player() {
  const [playerRows, setPlayerRows] = React.useState([]);
  const [teamNames, setTeamNames] = React.useState({
    1: "Olimpique Limon",
    2: "Bacakspor",
    3: "İmangücü İdman Yurdu",
    4: "Moda Kozmoz",
    5: "Lokomotif Haydarpaşa",
    6: "Crusader FK",
    7: "Dedeler FK",
    8: "Dereboyu",
    9: "Haddini Bilbao",
    10: "Şehremini FK",
    11: "Baklavasına FK",
    12: "Köyiçi FK",
    13: "Red Bull Sarıyer",
    14: "Cerrahpaşa FK",
    15: "Hakiki Gol FK",
    16: "Hamsispor",
  });

  React.useEffect(() => {
    axios.get("http://localhost:8080/api/player").then((res) => {
      var i;
      for (i = 0; i < res.data.length; i++) {
        res.data[i] = {
          ...res.data[i],
          id: i,
          teamID: teamNames[res.data[i].teamID],
        };
      }
      setPlayerRows(res.data);
    });
  }, []);

  const playerColumns = [
    { field: "playerID", headerName: "Player ID", width: 200, hide: true },
    { field: "firstName", headerName: "First Name", width: 130 },
    {
      field: "lastName",
      headerName: "Last Name",
      width: 130,
    },
    {
      field: "teamID",
      headerName: "Team ID",
      width: 130,
    },
    {
      field: "nationality",
      headerName: "Nationality",
      width: 130,
    },
    {
      field: "birthDate",
      headerName: "Birth Date",
      width: 180,
    },
    {
      field: "age",
      headerName: "Age",
      width: 180,
    },
    {
      field: "numberOfGoals",
      headerName: "Number Of Goals",
      width: 180,
    },
  ];

  return (
    <div
      style={{
        margin: "auto",
        marginTop: "20px",
        textAlign: "center",
        width: "75%",
      }}
    >
      <div style={{ height: 620, width: "100%", marginBottom: "10px" }}>
        <DataGrid rows={playerRows} columns={playerColumns} pageSize={10} />
      </div>
    </div>
  );
}
