import React from "react";
import { DataGrid } from "@material-ui/data-grid";
import axios from "axios";

export default function Team() {
  const [teamRows, setTeamRows] = React.useState([]);
  const [managerNames, setManagerNames] = React.useState({
    1: "Adem Tepe",
    2: "Yusuf Hacıoğlu",
    3: "Celalettin Doğruyol",
    4: "Oktay Camcı",
    5: "Hamit Akarsu",
    6: "Ekrem Yerebakan",
    7: "Mustafa  Sevimli",
    8: "Mehmet Aydın",
    9: "Mehmet Beşiroğlu",
    10: "Yasin Topçu",
    11: "Serdar Demirel",
    12: "Ali Yıldırım",
    13: "Barış Haskaya",
    14: "Muhammed Ali Kaldırım",
    15: "Habil Sucuoğlu",
    16: "Fatih Ay",
    17: "Murat Ok",
    18: "Kamil Sönmez",
    19: "Mustafa Karagöz",
    20: "Attila Ünlü",
    21: "Kazım Karabasan",
    22: "Berk Sevdalı",
    23: "Ahmet Gül",
    24: "Kadir Uhut",
    25: "Hüseyin Nohutçu",
    26: "Mustafa Bahçebaşı",
    27: "Burak Yurtsever",
    28: "Mehmet Soyaslan",
    29: "Mevlüt Mendeş",
    30: "Muhsin Görek",
    31: "Mehmet Kelek",
  });

  React.useEffect(() => {
    axios.get("http://localhost:8080/api/team").then((res) => {
      var i;
      for (i = 0; i < res.data.length; i++) {
        res.data[i] = {
          ...res.data[i],
          id: i,
          managerID: managerNames[res.data[i].managerID],
        };
      }
      setTeamRows(res.data);
    });
  }, []);

  const teamColumns = [
    { field: "teamID", headerName: "Team ID", width: 200 },
    { field: "name", headerName: "Name", width: 180 },
    {
      field: "location",
      headerName: "Location",
      width: 300,
    },
    {
      field: "managerID",
      headerName: "Manager ID",
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
        <DataGrid rows={teamRows} columns={teamColumns} pageSize={10} />
      </div>
    </div>
  );
}
