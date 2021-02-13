import React from "react";
import { DataGrid } from "@material-ui/data-grid";
import axios from "axios";

export default function Tournament() {
  const [tournamentRows, setTournamentRows] = React.useState([]);

  React.useEffect(() => {
    axios.get("http://localhost:8080/api/tournament").then((res) => {
      var i;
      for (i = 0; i < res.data.length; i++) {
        res.data[i] = {
          ...res.data[i],
          id: i,
        };
      }
      setTournamentRows(res.data);
    });
  }, []);

  const tournamentColumns = [
    { field: "tournametID", headerName: "Tournament ID", width: 200 },
    { field: "tournamentName", headerName: "Tournament Name", width: 500 },
    {
      field: "pitchID",
      headerName: "Pitch ID",
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
        <DataGrid
          rows={tournamentRows}
          columns={tournamentColumns}
          pageSize={10}
        />
      </div>
    </div>
  );
}
