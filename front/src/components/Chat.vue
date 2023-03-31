<template>
  <v-row>
    <v-col cols="4">
      <v-card
          class="mx-auto"
          max-width="344"
          variant="outlined"
        >
        <v-card-item>
          <div class="text-overline mb-1">
            入力したものをずんだもんに話してもらう
            <v-text-field v-model="val"></v-text-field>
          </div>
        </v-card-item>

        <v-card-actions>
          <v-btn variant="outlined" v-on:click="buttonClicked">
            送信
          </v-btn>
        </v-card-actions>
      </v-card>
      <audio class="audio"></audio>
    </v-col>

    <v-col cols="4">
      <v-card
          class="mx-auto"
          max-width="344"
          variant="outlined"
        >
        <v-card-item>
          <div class="text-overline mb-1">
            入力したものをChatGPTに飛ばす
            <v-text-field v-model="chatgpt"></v-text-field>
          </div>
        </v-card-item>

        <v-card-actions>
          <v-btn variant="outlined" v-on:click="chatGptClick">
            ChatGPTへ送信
          </v-btn>
        </v-card-actions>
      </v-card>
      <audio class="audio"></audio>
    </v-col>

    <v-col cols="4">
      <v-card
          class="mx-auto"
          max-width="344"
          variant="outlined"
        >
        <v-card-item>
            ずんだもんに話しかける
        </v-card-item>

        <v-card-actions>
          <v-btn variant="outlined" v-on:click="start">
            開始
          </v-btn>
          <v-btn variant="outlined" v-on:click="end">
            終了
          </v-btn>
        </v-card-actions>
      </v-card>
      <audio class="audio"></audio>
    </v-col>
  </v-row>
  <v-row>
    <v-col cols="12">
      <div class="output"></div>
    </v-col>
  </v-row>
</template>

<script setup lang="ts">
import { ref } from 'vue';
import axios from 'axios'

const buttonClicked = async () => {
  await createAudio(val.value);
}

const chatGptClick = async () => {
  const responseText = await requestChatAPI(chatgpt.value);
  await createAudio(responseText)
  const output = document.querySelector(".output");
  output.textContent = responseText;
}

const val = ref('initial')
const chatgpt = ref('chatGPT initial')

async function createAudio(text) {
  const audio = document.querySelector(".audio");
  audio.src = await getAudioURL(text);
  audio.play();
}

async function getAudioURL(text) {
  const query = await getQuery(text);
  const response = await axios.post(
    "http://localhost:50021/synthesis?speaker=1",
    query,
    { responseType: "blob" }
  );
  return URL.createObjectURL(response.data);
}

async function getQuery(text) {
  const response = await axios.post(
    `http://localhost:50021/audio_query?speaker=1&text=${text}`
  );
  return response.data;
}

const api_key = "各自のキー";

async function requestChatAPI(text) {
const headers = {
  "Content-Type": "application/json",
  Authorization: `Bearer ${api_key}`,
};

const messages = [
  {
    role: "user",
    content: text,
  },
];

const payload = {
  model: "gpt-3.5-turbo",
  max_tokens: 128,
  messages: messages,
};

const response = await axios.post(
  "https://api.openai.com/v1/chat/completions",
  payload,
  {
    headers: headers,
  }
);
console.log('ChatGPT送信')
return response.data.choices[0].message.content;
}


const recognition = new webkitSpeechRecognition();
const language = "ja";

recognition.lang = language;
recognition.interimResults = true;
recognition.continuous = true;
recognition.onresult = handleResult;

async function handleResult(event) {
  let finalTranscript = '';
  
  for (let i = event.resultIndex; i < event.results.length; i++) {
    const transcript = event.results[i][0].transcript;
    console.log(transcript);

    if (event.results[i].isFinal) {
      finalTranscript += transcript;
      const responseText = await requestChatAPI(finalTranscript);
      await createAudio(responseText);
      const output = document.querySelector(".output");
      output.textContent = responseText;
    }
  }
}

const start = () => {
  recognition.start();
};
const stop = () => {
  recognition.stop();
};
</script>
