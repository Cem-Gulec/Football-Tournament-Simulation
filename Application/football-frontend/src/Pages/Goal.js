import React from "react";
import { DataGrid } from "@material-ui/data-grid";
import axios from "axios";

export default function Goal() {
  const [goalRows, setGoalRows] = React.useState([]);
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
  const [playerNames, setPlayerNames] = React.useState({
    1: "Faruk Çakır",
    2: "Ömer Kaçmaz",
    3: "Kerem Saçaklı",
    4: "Metin Emin",
    5: "Kerem Sakın",
    6: "Şah  Muradov",
    7: "Zihni Elagöz",
    8: "Ali Yıldırım",
    9: "Vedat Artış",
    10: "Burak Kurt",
    11: "Osman Kalafat",
    12: "Süleyman Bulut",
    13: "Ömer Paftalı",
    14: "Erdem Şen",
    15: "Yunus Turhan",
    16: "Esad Büyük",
    17: "Hüseyin Durmuş",
    18: "Hamit Şimşek",
    19: "Semih Doğuş",
    20: "Hasan Şahinkoç",
    21: "Hong Lee",
    22: "Yusuf Polatlı",
    23: "Şinasi Öztürk",
    24: "Kerem Sarı",
    25: "Veysel Karagöz",
    26: "Kemal Perdeci",
    27: "Alperen Kapı",
    28: "Can Başgan",
    29: "Mustafa Güzel",
    30: "Bilal Beşikçi",
    31: "Selim Demirci",
    32: "Muhammed Yılmaz",
    33: "Oğuz Sarıoğlu",
    34: "Ali Yılmaz",
    35: "Mesut Gündüz",
    36: "Reza Mirzazade",
    37: "Sezer Mutlu",
    38: "Batuhan Atsız",
    39: "Hakan Karaman",
    40: "Oktay Durmaz",
    41: "Cengiz Şimşek",
    42: "Abdülhamit Özcan",
    43: "Servet Muhasebeci",
    44: "Necmi Köfte",
    45: "Hikmet Demirci",
    46: "Gökhan Uzun",
    47: "Makuone Kuboni",
    48: "Hüseyin Yardımcı",
    49: "Muratcan Gedik",
    50: "Furkan Karaca",
    51: "Serhan Karaca",
    52: "Ayodele Kanou",
    53: "Serhat Akıcı",
    54: "Emre Sözcü",
    55: "Tolga Çelik",
    56: "Furkan Selvi",
    57: "Mustafa Hamzaoğlu",
    58: "Ömer Karagülleoğlu",
    59: "Recep Atalay",
    60: "Burak Telli",
    61: "İsmet Çapkın",
    62: "Eser Adatepe",
    63: "Furkancan Uzunyol",
    64: "Mehmet Hasic",
    65: "Enes Kocaduvar",
    66: "Deniz Zeybek",
    67: "Yusuf Özyurt",
    68: "Niyazi Özyurt",
    69: "Oğuz Tepsici",
    70: "Yunus Şentepe",
    71: "Tolga Tokgöz",
    72: "Recep  Yürekli",
    73: "Cengizhan Dereli",
    74: "Enes Süzer",
    75: "Ali Şanlı",
    76: "İsmail Türkmen",
    77: "Ümit Üsküplü",
    78: "Kadir Öztürk",
    79: "Adil Özgüdenli",
    80: "Berk Tepecik",
    81: "Mirza Şahzade",
    82: "Kemal Tatlıcı",
    83: "Çağrı Göçebe",
    84: "Akif Muradov",
    85: "Celal Yüksektepe",
    86: "Enes Akhisarlı",
    87: "Furkan Kepelek",
    88: "Oğuzhan Bahçıvan",
    89: "Abdülkadir Djiboji",
    90: "Murat Tektaş",
    91: "Mahmut Kutalmış",
    92: "Recep Çetin",
    93: "Kerem Çalışkan",
    94: "Emre Kamışlık",
    95: "Ahmet Kızılkuş",
    96: "Arda Çakıl",
  });

  React.useEffect(() => {
    axios.get("http://localhost:8080/api/goal").then((res) => {
      var i;
      for (i = 0; i < res.data.length; i++) {
        res.data[i] = {
          ...res.data[i],
          id: i,
          homeTeamID: teamNames[res.data[i].homeTeamID],
          awayTeamID: teamNames[res.data[i].awayTeamID],
          playerID: playerNames[res.data[i].playerID],
        };
      }
      setGoalRows(res.data);
    });
  }, []);

  const goalColumns = [
    { field: "homeTeamID", headerName: "Home Team ID", width: 200 },
    { field: "awayTeamID", headerName: "Away Team ID", width: 200 },
    {
      field: "playerID",
      headerName: "Player ID",
      width: 200,
    },
    {
      field: "minitue",
      headerName: "Minute",
      width: 200,
    },
    {
      field: "week",
      headerName: "Week",
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
        <DataGrid rows={goalRows} columns={goalColumns} pageSize={10} />
      </div>
    </div>
  );
}
