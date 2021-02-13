import React from "react";
import PropTypes from "prop-types";
import SwipeableViews from "react-swipeable-views";
import { makeStyles, useTheme } from "@material-ui/core/styles";
import AppBar from "@material-ui/core/AppBar";
import Tabs from "@material-ui/core/Tabs";
import Tab from "@material-ui/core/Tab";
import Typography from "@material-ui/core/Typography";
import Box from "@material-ui/core/Box";
import { DataGrid } from "@material-ui/data-grid";
import axios from "axios";

function TabPanel(props) {
  const { children, value, index, ...other } = props;

  return (
    <div
      role="tabpanel"
      hidden={value !== index}
      id={`full-width-tabpanel-${index}`}
      aria-labelledby={`full-width-tab-${index}`}
      {...other}
    >
      {value === index && (
        <Box p={3}>
          <Typography>{children}</Typography>
        </Box>
      )}
    </div>
  );
}

TabPanel.propTypes = {
  children: PropTypes.node,
  index: PropTypes.any.isRequired,
  value: PropTypes.any.isRequired,
};

function a11yProps(index) {
  return {
    id: `full-width-tab-${index}`,
    "aria-controls": `full-width-tabpanel-${index}`,
  };
}

const useStyles = makeStyles((theme) => ({
  root: {
    backgroundColor: theme.palette.background.paper,
    width: 1100,
  },
}));

export default function Home() {
  const classes = useStyles();
  const theme = useTheme();
  const [value, setValue] = React.useState(0);
  const [matchRows, setMatchRows] = React.useState([]);
  const [tournamentTeamRows, setTournamentTeamRows] = React.useState([]);
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
    let one = "http://localhost:8080/api/match";
    let two = "http://localhost:8080/api/tournamentTeam";
    let three = "http://localhost:8080/api/awards";

    const requestOne = axios.get(one);
    const requestTwo = axios.get(two);
    const requestThree = axios.get(three);

    axios
      .all([requestOne, requestTwo, requestThree])
      .then(
        axios.spread((...responses) => {
          const responseOne = responses[0];
          const responseTwo = responses[1];
          const responesThree = responses[2];

          var i;
          for (i = 0; i < responseOne.data.length; i++) {
            responseOne.data[i] = {
              ...responseOne.data[i],
              id: i,
              homeTeamID: teamNames[responseOne.data[i].homeTeamID],
              awayTeamID: teamNames[responseOne.data[i].awayTeamID],
              refereeID: refereeNames[responseOne.data[i].refereeID],
            };
          }
          setMatchRows(responseOne.data);
          for (i = 0; i < responseTwo.data.length; i++) {
            responseTwo.data[i] = {
              ...responseTwo.data[i],
              id: i,
              teamID: teamNames[responseTwo.data[i].teamID],
            };
          }
          setTournamentTeamRows(responseTwo.data);
          for (i = 0; i < responesThree.data.length; i++) {
            responesThree.data[i] = {
              ...responesThree.data[i],
              id: i,
              championTeamID: teamNames[responesThree.data[i].championTeamID],
              mostValuablePlayerID:
                playerNames[responesThree.data[i].mostValuablePlayerID],
              mostValuableCoachID:
                managerNames[responesThree.data[i].mostValuableCoachID],
            };
          }
          setAwardsRows(responesThree.data);
        })
      )
      .catch((errors) => {
        // react on errors.
      });
  }, []);

  const groupsMatchColumns = [
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
      hide: true,
    },
  ];

  const groupsTournamentTeamColumns = [
    { field: "tournamentID", headerName: "Tournament ID", width: 150 },
    { field: "teamID", headerName: "Team ID", width: 150 },
    { field: "groupName", headerName: "Group Name", width: 150, hide: true },
    {
      field: "numberOfMatchPlayed",
      headerName: "Number Of Match Played",
      width: 150,
    },
    {
      field: "won",
      headerName: "Won",
      width: 150,
    },
    {
      field: "draw",
      headerName: "Draw",
      width: 150,
    },
    {
      field: "loss",
      headerName: "Loss",
      width: 150,
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
      width: 150,
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

  const stagesTournamentTeamColumns = [
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
      width: 150,
    },
    {
      field: "draw",
      headerName: "Draw",
      width: 150,
    },
    {
      field: "loss",
      headerName: "Loss",
      width: 150,
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
      width: 150,
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
      hide: true,
    },
  ];

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

  const handleChange = (event, newValue) => {
    setValue(newValue);
  };

  const handleChangeIndex = (index) => {
    setValue(index);
  };

  return (
    <div className={classes.root} style={{ margin: "auto", marginTop: "20px" }}>
      <AppBar position="static" color="default">
        <Tabs
          value={value}
          onChange={handleChange}
          indicatorColor="primary"
          textColor="primary"
          variant="fullWidth"
          aria-label="full width tabs example"
        >
          <Tab label="Groups" {...a11yProps(0)} />
          <Tab label="Quarter Final" {...a11yProps(1)} />
          <Tab label="Semi Final" {...a11yProps(2)} />
          <Tab label="Final" {...a11yProps(3)} />
          <Tab label="Champion" {...a11yProps(4)} />
        </Tabs>
      </AppBar>
      <SwipeableViews
        axis={theme.direction === "rtl" ? "x-reverse" : "x"}
        index={value}
        onChangeIndex={handleChangeIndex}
      >
        <TabPanel value={value} index={0} dir={theme.direction}>
          <h2>Group A</h2>
          <h4>Match</h4>
          <div style={{ height: 400, width: "100%", marginBottom: "10px" }}>
            <DataGrid
              rows={matchRows}
              columns={groupsMatchColumns}
              pageSize={10}
              filterModel={{
                items: [
                  {
                    columnField: "matchStage",
                    operatorValue: "equals",
                    value: "GROUP A",
                  },
                ],
              }}
            />
          </div>
          <h4>Tournament Team</h4>
          <div style={{ height: 400, width: "100%", marginBottom: "10px" }}>
            <DataGrid
              rows={tournamentTeamRows}
              columns={groupsTournamentTeamColumns}
              pageSize={10}
              filterModel={{
                items: [
                  {
                    columnField: "groupName",
                    operatorValue: "equals",
                    value: "A",
                  },
                ],
              }}
            />
          </div>
          <h2>Group B</h2>
          <h4>Match</h4>
          <div style={{ height: 400, width: "100%", marginBottom: "10px" }}>
            <DataGrid
              rows={matchRows}
              columns={groupsMatchColumns}
              pageSize={10}
              filterModel={{
                items: [
                  {
                    columnField: "matchStage",
                    operatorValue: "equals",
                    value: "GROUP B",
                  },
                ],
              }}
            />
          </div>
          <h4>Tournament Team</h4>
          <div style={{ height: 400, width: "100%", marginBottom: "10px" }}>
            <DataGrid
              rows={tournamentTeamRows}
              columns={groupsTournamentTeamColumns}
              pageSize={10}
              filterModel={{
                items: [
                  {
                    columnField: "groupName",
                    operatorValue: "equals",
                    value: "B",
                  },
                ],
              }}
            />
          </div>
          <h2>Group C</h2>
          <h4>Match</h4>
          <div style={{ height: 400, width: "100%", marginBottom: "10px" }}>
            <DataGrid
              rows={matchRows}
              columns={groupsMatchColumns}
              pageSize={10}
              filterModel={{
                items: [
                  {
                    columnField: "matchStage",
                    operatorValue: "equals",
                    value: "GROUP C",
                  },
                ],
              }}
            />
          </div>
          <h4>Tournament Team</h4>
          <div style={{ height: 400, width: "100%", marginBottom: "10px" }}>
            <DataGrid
              rows={tournamentTeamRows}
              columns={groupsTournamentTeamColumns}
              pageSize={10}
              filterModel={{
                items: [
                  {
                    columnField: "groupName",
                    operatorValue: "equals",
                    value: "C",
                  },
                ],
              }}
            />
          </div>
          <h2>Group D</h2>
          <h4>Match</h4>
          <div style={{ height: 400, width: "100%", marginBottom: "10px" }}>
            <DataGrid
              rows={matchRows}
              columns={groupsMatchColumns}
              pageSize={10}
              filterModel={{
                items: [
                  {
                    columnField: "matchStage",
                    operatorValue: "equals",
                    value: "GROUP D",
                  },
                ],
              }}
            />
          </div>
          <h4>Tournament Team</h4>
          <div style={{ height: 400, width: "100%", marginBottom: "10px" }}>
            <DataGrid
              rows={tournamentTeamRows}
              columns={groupsTournamentTeamColumns}
              pageSize={10}
              filterModel={{
                items: [
                  {
                    columnField: "groupName",
                    operatorValue: "equals",
                    value: "D",
                  },
                ],
              }}
            />
          </div>
        </TabPanel>
        <TabPanel value={value} index={1} dir={theme.direction}>
          Quarter Final
          <h4>Match</h4>
          <div style={{ height: 400, width: "100%", marginBottom: "10px" }}>
            <DataGrid
              rows={matchRows}
              columns={groupsMatchColumns}
              pageSize={10}
              filterModel={{
                items: [
                  {
                    columnField: "matchStage",
                    operatorValue: "equals",
                    value: "QUARTER FINALS",
                  },
                ],
              }}
            />
          </div>
          <h4>Tournament Team</h4>
          <div style={{ height: 400, width: "100%", marginBottom: "10px" }}>
            <DataGrid
              rows={tournamentTeamRows}
              columns={stagesTournamentTeamColumns}
              pageSize={10}
              filterModel={{
                items: [
                  {
                    columnField: "stage",
                    operatorValue: "equals",
                    value: "Quarter Finals",
                  },
                ],
              }}
            />
          </div>
        </TabPanel>
        <TabPanel value={value} index={2} dir={theme.direction}>
          Semi Final
          <h4>Match</h4>
          <div style={{ height: 400, width: "100%", marginBottom: "10px" }}>
            <DataGrid
              rows={matchRows}
              columns={groupsMatchColumns}
              pageSize={10}
              filterModel={{
                items: [
                  {
                    columnField: "matchStage",
                    operatorValue: "equals",
                    value: "SEMI FINALS",
                  },
                ],
              }}
            />
          </div>
          <h4>Tournament Team</h4>
          <div style={{ height: 400, width: "100%", marginBottom: "10px" }}>
            <DataGrid
              rows={tournamentTeamRows}
              columns={stagesTournamentTeamColumns}
              pageSize={10}
              filterModel={{
                items: [
                  {
                    columnField: "stage",
                    operatorValue: "equals",
                    value: "Semi Finals",
                  },
                ],
              }}
            />
          </div>
        </TabPanel>
        <TabPanel value={value} index={3} dir={theme.direction}>
          Final
          <h4>Match</h4>
          <div style={{ height: 400, width: "100%", marginBottom: "10px" }}>
            <DataGrid
              rows={matchRows}
              columns={groupsMatchColumns}
              pageSize={10}
              filterModel={{
                items: [
                  {
                    columnField: "matchStage",
                    operatorValue: "equals",
                    value: "FINALS",
                  },
                ],
              }}
            />
          </div>
          <h4>Tournament Team</h4>
          <div style={{ height: 400, width: "100%", marginBottom: "10px" }}>
            <DataGrid
              rows={tournamentTeamRows}
              columns={stagesTournamentTeamColumns}
              pageSize={10}
              filterModel={{
                items: [
                  {
                    columnField: "stage",
                    operatorValue: "equals",
                    value: "Finals",
                  },
                ],
              }}
            />
          </div>
        </TabPanel>
        <TabPanel value={value} index={4} dir={theme.direction}>
          Champion
          <h4>Awards</h4>
          <div style={{ height: 400, width: "100%", marginBottom: "10px" }}>
            <DataGrid rows={awardsRows} columns={awardsColumns} pageSize={10} />
          </div>
        </TabPanel>
      </SwipeableViews>
    </div>
  );
}
