import React from "react";
import { makeStyles } from "@material-ui/core/styles";
import AppBar from "@material-ui/core/AppBar";
import Toolbar from "@material-ui/core/Toolbar";
import Typography from "@material-ui/core/Typography";
import Link from "@material-ui/core/Link";
import Button from "@material-ui/core/Button";
import Menu from "@material-ui/core/Menu";
import MenuItem from "@material-ui/core/MenuItem";

const useStyles = makeStyles((theme) => ({
  "@global": {
    ul: {
      margin: 0,
      padding: 0,
      listStyle: "none",
    },
  },
  appBar: {
    borderBottom: `1px solid ${theme.palette.divider}`,
  },
  toolbar: {
    flexWrap: "wrap",
  },
  toolbarTitle: {
    flexGrow: 1,
  },
  link: {
    margin: theme.spacing(1, 1.5),
  },
}));

export default function DenseAppBar() {
  const classes = useStyles();
  const [anchorEl, setAnchorEl] = React.useState(null);

  const handleClick = (event) => {
    setAnchorEl(event.currentTarget);
  };

  const handleClose = () => {
    setAnchorEl(null);
  };

  return (
    <div className={classes.root}>
      <AppBar
        position="static"
        color="default"
        elevation={0}
        className={classes.appBar}
      >
        <Toolbar className={classes.toolbar}>
          <Typography
            variant="h6"
            color="inherit"
            noWrap
            className={classes.toolbarTitle}
          >
            <Link
              variant="button"
              color="textPrimary"
              href="/"
              className={classes.link}
              style={{ textDecoration: "none", fontSize: "18px" }}
            >
              FOOTBALL TOURNAMENT
            </Link>
          </Typography>
          <nav>
            <Link
              variant="button"
              color="textPrimary"
              href="/"
              className={classes.link}
            >
              Home
            </Link>
            <Button
              aria-controls="simple-menu"
              aria-haspopup="true"
              onClick={handleClick}
            >
              Tables
            </Button>
            <Menu
              id="simple-menu"
              anchorEl={anchorEl}
              keepMounted
              open={Boolean(anchorEl)}
              onClose={handleClose}
            >
              <MenuItem onClick={handleClose}>
                <Link variant="button" color="textPrimary" href="/awards">
                  Awards
                </Link>
              </MenuItem>
              <MenuItem onClick={handleClose}>
                <Link variant="button" color="textPrimary" href="/goal">
                  Goal
                </Link>
              </MenuItem>
              <MenuItem onClick={handleClose}>
                <Link variant="button" color="textPrimary" href="/manager">
                  Manager
                </Link>
              </MenuItem>
              <MenuItem onClick={handleClose}>
                <Link variant="button" color="textPrimary" href="/match">
                  Match
                </Link>
              </MenuItem>
              <MenuItem onClick={handleClose}>
                <Link variant="button" color="textPrimary" href="/pitch">
                  Pitch
                </Link>
              </MenuItem>
              <MenuItem onClick={handleClose}>
                <Link variant="button" color="textPrimary" href="/player">
                  Player
                </Link>
              </MenuItem>
              <MenuItem onClick={handleClose}>
                <Link
                  variant="button"
                  color="textPrimary"
                  href="/playerPosition"
                >
                  Player Position
                </Link>
              </MenuItem>
              <MenuItem onClick={handleClose}>
                <Link variant="button" color="textPrimary" href="/referee">
                  Referee
                </Link>
              </MenuItem>
              <MenuItem onClick={handleClose}>
                <Link variant="button" color="textPrimary" href="/team">
                  Team
                </Link>
              </MenuItem>
              <MenuItem onClick={handleClose}>
                <Link variant="button" color="textPrimary" href="/tournament">
                  Tournament
                </Link>
              </MenuItem>
              <MenuItem onClick={handleClose}>
                <Link
                  variant="button"
                  color="textPrimary"
                  href="/tournamentTeam"
                >
                  Tournament Team
                </Link>
              </MenuItem>
            </Menu>
            <Link
              variant="button"
              color="textPrimary"
              href="/contactUs"
              className={classes.link}
            >
              Contact Us
            </Link>
          </nav>
        </Toolbar>
      </AppBar>
    </div>
  );
}
