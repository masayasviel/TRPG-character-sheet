<template>
  <v-app>
    <v-app-bar
      color="grey lighten-3"
      app
    >
      <v-toolbar-title>TRPG Character Sheet</v-toolbar-title>
    </v-app-bar>
    <v-main app>
      <Profile
        :propsCharacterName.sync="characterName"
        :propsOccupation.sync="occupation"
        :propsRemarks.sync="remarks"
        app
      />
      <Status
        :propsStatus.sync="status"
        :propsFixStatus.sync="fixStatus"
        @diceRollStatus="randomlyDetermineStatus"
        app
      />
      <Skills
        :propDEX.sync="status.dex"
        :propEDU.sync="status.edu"
      />
      <v-snackbar v-model="snackbarStatus.snackbar" :timeout="timeout">
        {{ snackbarStatus.text }}
        <template v-slot:action="{ attrs }">
          <v-btn
            color="blue"
            text
            v-bind="attrs"
            @click="snackbarStatus.snackbar=false"
          >
            Close
          </v-btn>
        </template>
      </v-snackbar>
    </v-main>
  </v-app>
</template>

<script lang="ts">
import { Vue, Component } from "vue-property-decorator";

import Profile from "@/components/profile.vue";
import Status from "@/components/status.vue";
import Skills from "@/components/skills.vue";

/**
 * ダイスを振る
 * @param times 回数
 * @param num ダイスの最大値
 * @returns res 結果の合計
 */
function dice(times: number, num: number): number {
  let res = 0;
  for (let i = 0;i < times;i++) {
    res += Math.ceil(Math.random()*num);
  }
  return res;
}

/**
 * ダメージボーナスを計算する
 * @param param str+siz
 * @returns res ダメージボーナス
 */
// function checkDamageBonus(param: number): string {
//   let res = "+0";
//   if (param <= 12) {
//     res = "-1D6";
//   } else if (param <= 16) {
//     res = "-1D4";
//   } else if (param <= 24) {
//     res = "+0";
//   } else if (param <= 32) {
//     res = "+1D4";
//   } else if (param <= 40) {
//     res = "+1D6"
//   } else {
//     res = `+${Math.ceil((param - 40) / 16) + 1}D6`;
//   }
//   return res;
// }

@Component({
  components: {
    Profile,
    Status,
    Skills
  }
})
export default class App extends Vue {
  private characterName = "";
  private occupation = "";
  private remarks = "";
  private status= {
    str: 0,
    con: 0,
    siz: 0,
    int: 0,
    pow: 0,
    dex: 0,
    app: 0,
    edu: 0
  };
  private fixStatus = {
    str: 0,
    con: 0,
    siz: 0,
    int: 0,
    pow: 0,
    dex: 0,
    app: 0,
    edu: 0,
    hp: 0,
    mp: 0,
    san: 0,
    idea: 0,
    lucky: 0,
    knowledge: 0,
  };
  // skill
  private cthulhuMythos = {
    name: "クトゥルフ神話",
    initValue: 0,
    occupationPoint: 0,
    interestPoint: 0,
    fixPoint: 0
  };
  // snackbar status
  private snackbarStatus = {
    snackbar: false,
    text: "dice rolled.",
    timeout: 1500,
  }

  // methods
  /**
  * キャラのステータスを決定する
  */
  private randomlyDetermineStatus() {
    this.status.str = dice(3, 6);
    this.status.con = dice(3, 6);
    this.status.pow = dice(3, 6);
    this.status.dex = dice(3, 6);
    this.status.app = dice(3, 6);
    this.status.siz = dice(2, 6) + 6;
    this.status.int = dice(2, 6) + 6;
    this.status.edu = dice(3, 6) + 3;
    this.snackbarStatus.snackbar = true;
  }
}
</script>
