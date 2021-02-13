import React from "react";
import { DataGrid } from "@material-ui/data-grid";
import axios from "axios";

export default function TournamentTeam() {
  const [tournamentTeamRows, setTournamentTeamRows] = React.useState([]);
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
    axios.get("http://localhost:8080/api/tournamentTeam").then((res) => {
      var i;
      for (i = 0; i < res.data.length; i++) {
        res.data[i] = {
          ...res.data[i],
          id: i,
          teamID: teamNames[res.data[i].teamID],
        };
      }
      setTournamentTeamRows(res.data);
    });
  }, []);

  const groupsTournamentTeamColumns = [
    { field: "tournamentID", headerName: "Tournament ID", width: 150 },
    { field: "teamID", headerName: "Team ID", width: 150 },
    { field: "groupName", headerName: "Group Name", width: 150 },
    {
      field: "numberOfMatchPlayed",
      headerName: "Number Of Match Played",
      width: 150,
    },
    {
      field: "won",
      headerName: "Won",
      width: 100,
    },
    {
      field: "draw",
      headerName: "Draw",
      width: 100,
    },
    {
      field: "loss",
      headerName: "Loss",
      width: 100,
    },
    {
      field: "groupPoint",
      headerName: "Group Point",
      width: 150,
    },
    {
      field: "goalScored",
      headerName: "Goal Scored",
      width: 150,
    },
    {
      field: "goalConceded",
      headerName: "Goal Conceded",
      width: 150,
    },
    {
      field: "average",
      headerName: "Average",
      width: 110,
    },
    {
      field: "groupPosition",
      headerName: "Group Position",
      width: 150,
    },
    {
      field: "stage",
      headerName: "Stage",
      width: 150,
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
        <DataGrid
          rows={tournamentTeamRows}
          columns={groupsTournamentTeamColumns}
          pageSize={10}
        />
      </div>
    </div>
  );
}
