importScripts('https://www.gstatic.com/firebasejs/8.2.7/firebase-app.js');
importScripts('https://www.gstatic.com/firebasejs/8.2.7/firebase-messaging.js');

const firebaseConfig = {
  apiKey: 'AIzaSyD5AevZArnmigjRBb7oeMowYtttLNB1XXg',
  authDomain: 'servoti.firebaseapp.com',
  projectId: 'servoti',
  storageBucket: 'servoti.appspot.com',
  messagingSenderId: '715440171496',
  appId: '1:715440171496:web:6e19b6cd8eb531b4659c5d',
  measurementId: 'G-2BMCQDV44R',
};

const app = firebase.initializeApp(firebaseConfig);
