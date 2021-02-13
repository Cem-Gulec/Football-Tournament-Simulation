import React from "react";
import { DataGrid } from "@material-ui/data-grid";
import axios from "axios";

export default function Match() {
  const [matchRows, setMatchRows] = React.useState([]);
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
  const [refereeNames, setRefereeNames] = React.useState({
    1: "Yaman Şaner",
    2: "Hasan Salihoğlu",
    3: "Hüseyin Halsiz",
    4: "Mahmut Aslantaş",
    5: "Ali Dinke",
    6: "Oğuzhan Tepe",
    7: "Yıldırım  Türkoğlu",
    8: "Hakan Marangoz",
    9: "Mehmet Ali Kocatepe",
    10: "Mustafa Kuzey",
    11: "Hasan Akbaba",
    12: "İbrahim Tezcan",
    13: "Tuna Sezer",
    14: "Kerim Yıldırım",
    15: "İlyas Bozbaş",
    16: "Emre Kuserli",
    17: "Narin Kasapoğlu",
    18: "Hasan Rışvanlı",
    19: "Serdar Bora",
    20: "Sezgin Ülker",
    21: "Muhammed Temel",
    22: "Kıvanç Samsa",
    23: "Abdurrahman Fuat",
    24: "Tekin Kasar",
    25: "Ulaş Elçi",
    26: "Mehmet Şentürk",
    27: "Evren Özalp",
    28: "Özden Akdur",
    29: "Nezih Uyluk",
    30: "Erem Çalış",
    31: "Kadir Kulak",
  });

  React.useEffect(() => {
    axios.get("http://localhost:8080/api/match").then((res) => {
      var i;
      for (i = 0; i < res.data.length; i++) {
        res.data[i] = {
          ...res.data[i],
          id: i,
          homeTeamID: teamNames[res.data[i].homeTeamID],
          awayTeamID: teamNames[res.data[i].awayTeamID],
          refereeID: refereeNames[res.data[i].refereeID]
        };
      }
      setMatchRows(res.data);
    });
  }, []);

  const matchColumns = [
    { field: "homeTeamID", headerName: "Home Team ID", width: 150 },
    { field: "awayTeamID", headerName: "Away Team ID", width: 150 },
    { field: "week", headerName: "Week", width: 150 },
    {
      field: "refereeID",
      headerName: "Referee ID",
      width: 150,
    },
    {
      field: "date",
      headerName: "Date",
      width: 150,
    },
    {
      field: "finalResult",
      headerName: "Final Result",
      width: 150,
    },
    {
      field: "matchStage",
      headerName: "Match Stage",
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
      <div style={{ height: 600, width: "100%", marginBottom: "10px" }}>
        <DataGrid rows={matchRows} columns={matchColumns} pageSize={10} />
      </div>
    </div>
  );
}
