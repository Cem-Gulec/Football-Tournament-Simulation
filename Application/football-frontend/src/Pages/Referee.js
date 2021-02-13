import React from "react";
import { DataGrid } from "@material-ui/data-grid";
import axios from "axios";

export default function Referee() {
  const [refereeRows, setrefereeRows] = React.useState([]);
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
    axios.get("http://localhost:8080/api/referee").then((res) => {
      var i;
      for (i = 0; i < res.data.length; i++) {
        res.data[i] = {
          ...res.data[i],
          id: i,
          refereeID: refereeNames[res.data[i].refereeID],
        };
      }
      setrefereeRows(res.data);
    });
  }, []);

  const refereeColumns = [
    { field: "refereeID", headerName: "Referee ID", width: 200 },
    { field: "lastName", headerName: "Last Name", width: 130 },
    {
      field: "yearsOfExperience",
      headerName: "Years Of Experience",
      width: 300,
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
        <DataGrid rows={refereeRows} columns={refereeColumns} pageSize={10} />
      </div>
    </div>
  );
}
