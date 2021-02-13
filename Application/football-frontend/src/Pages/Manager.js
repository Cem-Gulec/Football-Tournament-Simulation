import React from "react";
import { DataGrid } from "@material-ui/data-grid";
import axios from "axios";

export default function Manager() {
  const [managerRows, setmanagerRows] = React.useState([]);

  React.useEffect(() => {
    axios.get("http://localhost:8080/api/manager").then((res) => {
      var i;
      for (i = 0; i < res.data.length; i++) {
        res.data[i] = {
          ...res.data[i],
          id: i,
        };
      }
      setmanagerRows(res.data);
    });
  }, []);

  const managerColumns = [
    { field: "managerID", headerName: "Manager ID", width: 200 },
    { field: "firstName", headerName: "First Name", width: 200 },
    {
      field: "lastName",
      headerName: "Last Name",
      width: 200,
    },
    {
      field: "nationality",
      headerName: "Nationality",
      width: 200,
    },
    {
      field: "birthDate",
      headerName: "Birth Date",
      width: 200,
    },
    {
      field: "age",
      headerName: "Age",
      width: 200,
    },
    {
      field: "yearsOfExperience",
      headerName: "Years Of Experience",
      width: 200,
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
      <div style={{ height: 650, width: "100%", marginBottom: "10px" }}>
        <DataGrid rows={managerRows} columns={managerColumns} pageSize={10} />
      </div>
    </div>
  );
}
