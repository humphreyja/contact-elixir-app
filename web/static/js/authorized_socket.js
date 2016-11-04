import {Socket} from "phoenix";

let authSocket = new Socket("/socket");
authSocket.connect();




export default sendMessage;
