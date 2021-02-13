import React from "react";
import CssBaseline from "@material-ui/core/CssBaseline";
import Typography from "@material-ui/core/Typography";
import { makeStyles } from "@material-ui/core/styles";
import Container from "@material-ui/core/Container";
import InstagramIcon from "@material-ui/icons/Instagram";
import TwitterIcon from "@material-ui/icons/Twitter";
import LinkedInIcon from "@material-ui/icons/LinkedIn";
import FacebookIcon from "@material-ui/icons/Facebook";
import Link from "@material-ui/core/Link";

function Copyright() {
  return (
    <Typography variant="body2" color="textSecondary">
      <Link href="https://www.instagram.com" style={{ color: "#0000008a", marginRight: "5px" }}>
        <InstagramIcon></InstagramIcon>
      </Link>
      <Link href="https://twitter.com/home" style={{ color: "#0000008a", marginRight: "5px" }}>
        <TwitterIcon></TwitterIcon>
      </Link>
      <Link href="https://www.linkedin.com/feed/" style={{ color: "#0000008a", marginRight: "5px" }}>
        <LinkedInIcon></LinkedInIcon>
      </Link>
      <Link href="https://www.facebook.com" style={{ color: "#0000008a", marginRight: "5px" }}>
        <FacebookIcon></FacebookIcon>
      </Link>
    </Typography>
  );
}

const useStyles = makeStyles((theme) => ({
  root: {
    display: "flex",
    flexDirection: "column",
    minHeight: "30vh",
  },
  footer: {
    padding: theme.spacing(3, 2),
    marginTop: "auto",
    textAlign: "center",
    backgroundColor:
      theme.palette.type === "light"
        ? theme.palette.grey[200]
        : theme.palette.grey[800],
  },
}));

export default function Footer() {
  const classes = useStyles();

  return (
    <div className={classes.root}>
      <CssBaseline />
      <footer className={classes.footer}>
        <Container maxWidth="sm">
          <Typography variant="body1">MALTEPE AYDINOĞLU CLUB</Typography>
          <Copyright />
        </Container>
      </footer>
    </div>
  );
}
