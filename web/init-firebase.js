// Import the functions you need from the SDKs you need
import { initializeApp } from "firebase/app";
import { getAnalytics } from "firebase/analytics";
// TODO: Add SDKs for Firebase products that you want to use
// https://firebase.google.com/docs/web/setup#available-libraries

// Your web app's Firebase configuration
// For Firebase JS SDK v7.20.0 and later, measurementId is optional
const firebaseConfig = {
    apiKey: "AIzaSyDiggZ-rq2eom60wolRnTps4Uqe8Dwumuo",
    authDomain: "chat-app-27a76.firebaseapp.com",
    projectId: "chat-app-27a76",
    storageBucket: "chat-app-27a76.appspot.com",
    messagingSenderId: "349467163675",
    appId: "1:349467163675:web:5c34a667b0b78581efccbe",
    measurementId: "G-GG4B4PZFS5"
};

// Initialize Firebase
const app = initializeApp(firebaseConfig);
const analytics = getAnalytics(app);