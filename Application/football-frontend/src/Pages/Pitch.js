import React from "react";
import { DataGrid } from "@material-ui/data-grid";
import axios from "axios";

export default function Pitch() {
  const [pitchRows, setpitchRows] = React.useState([]);

  React.useEffect(() => {
    axios.get("http://localhost:8080/api/pitch").then((res) => {
      var i;
      for (i = 0; i < res.data.length; i++) {
        res.data[i] = {
          ...res.data[i],
          id: i,
        };
      }
      setpitchRows(res.data);
    });
  }, []);

  const pitchColumns = [
    { field: "pitchID", headerName: "Pitch ID", width: 150 },
    { field: "name", headerName: "Name", width: 150 },
    { field: "location", headerName: "Location", width: 150 },
    {
      field: "ownerName",
      headerName: "Owner Name",
      width: 150,
    },
    {
      field: "businessNumber",
      headerName: "Business Number",
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
      <div style={{ height: 400, width: "100%", marginBottom: "10px" }}>
        <DataGrid rows={pitchRows} columns={pitchColumns} pageSize={10} />
      </div>
    </div>
  );
}
