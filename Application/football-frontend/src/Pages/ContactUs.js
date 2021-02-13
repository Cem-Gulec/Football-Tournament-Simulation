import React from "react";
import "./ContactUs.css";

export default function ContactUs() {
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
        <h1>Contact Us</h1>
        <form>
          <input
            type="text"
            placeholder="Email"
            name="Email"
            className="customInput"
          />
          <br />
          <textarea
            rows="4"
            cols="50"
            className="customInput"
            placeholder="Message"
          ></textarea>
          <br />
          <input type="submit" className="customSubmit" />
        </form>
      </div>
    </div>
  );
}
