import React from "react";
import { DataGrid } from "@material-ui/data-grid";
import axios from "axios";

export default function Awards() {
  const [awardsRows, setAwardsRows] = React.useState([]);
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
    axios.get("http://localhost:8080/api/awards").then((res) => {
      var i;
      for (i = 0; i < res.data.length; i++) {
        res.data[i] = {
          ...res.data[i],
          id: i,
          championTeamID: teamNames[res.data[i].championTeamID],
          mostValuablePlayerID:
            playerNames[res.data[i].mostValuablePlayerID],
          mostValuableCoachID:
            managerNames[res.data[i].mostValuableCoachID],
        };
      }
      setAwardsRows(res.data);
    });
  }, []);

  const awardsColumns = [
    { field: "seasonAwardsID", headerName: "Season Awards ID", width: 200 },
    { field: "championTeamID", headerName: "Champion Team ID", width: 200 },
    {
      field: "mostValuablePlayerID",
      headerName: "Most Valuable Player ID",
      width: 200,
    },
    {
      field: "mostValuableCoachID",
      headerName: "Most Valuable Coach ID",
      width: 200,
    },
    {
      field: "tournamentID",
      headerName: "Tournament ID",
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
      <div style={{ height: 400, width: "100%", marginBottom: "10px" }}>
        <DataGrid rows={awardsRows} columns={awardsColumns} pageSize={10} />
      </div>
    </div>
  );
}
