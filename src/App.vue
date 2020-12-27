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
        :propSumOccupationPoint.sync="sumOccupationPoint"
        :propSumInterestPoint.sync="sumInterestPoint"
      />
      <table class="use-playing">
        <tr>
          <v-tooltip top>
            <template v-slot:activator="{ on, attrs }">
              <th v-bind="attrs" v-on="on">職業ポイント</th>
            </template>
            <span>EDU×20</span>
          </v-tooltip>
          <td><span class="non-input-status">{{ sumOccupationPoint }} / {{ Number(status.edu) * 20 }}</span></td>
        </tr>
        <tr>
          <v-tooltip top>
            <template v-slot:activator="{ on, attrs }">
              <th v-bind="attrs" v-on="on">興味ポイント</th>
            </template>
            <span>INT×10</span>
          </v-tooltip>
          <td><span class="non-input-status">{{ sumInterestPoint }} / {{ Number(status.int) * 10 }}</span></td>
        </tr>
        <tr>
          <v-tooltip top>
            <template v-slot:activator="{ on, attrs }">
              <th v-bind="attrs" v-on="on">SAN値上限</th>
            </template>
            <span>99-クトゥルフ神話技能</span>
          </v-tooltip>
          <td><span class="non-input-status">{{ 99-Number(this.cthulhuMythos.fixPoint) }}</span></td>
        </tr>
        <tr>
          <th>SAN値</th>
          <td>
            <input type="number" class="input-status" :value="currentSanValue" min="0"> / <span class="non-input-status">{{ currentSanValue }}</span>
          </td>
        </tr>
        <tr>
          <th>HP</th>
          <td>
            <input type="number" class="input-status" :value="currentHPValue" min="0"> / <span class="non-input-status">{{ currentHPValue }}</span>
          </td>
        </tr>
        <tr>
          <th>MP</th>
          <td>
            <input type="number" class="input-status" :value="currentMPValue" min="0"> / <span class="non-input-status">{{ currentMPValue }}</span>
          </td>
        </tr>
        <tr>
          <th>ダメージボーナス</th>
          <td><span class="non-input-status">{{ damageBonus }}</span></td>
        </tr>
        <tr>
          <th>クトゥルフ神話技能</th>
          <td><input type="number" class="input-status" v-model="cthulhuMythos.fixPoint" min="0"></td>
        </tr>
      </table>
      <v-snackbar v-model="snackbarStatus.snackbar" :timeout="snackbarStatus.timeout">
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
function checkDamageBonus(param: number): string {
  let res = "+0";
  if (param <= 12) {
    res = "-1D6";
  } else if (param <= 16) {
    res = "-1D4";
  } else if (param <= 24) {
    res = "+0";
  } else if (param <= 32) {
    res = "+1D4";
  } else if (param <= 40) {
    res = "+1D6"
  } else {
    res = `+${Math.ceil((param - 40) / 16) + 1}D6`;
  }
  return res;
}

@Component({
  components: {
    Profile,
    Status,
    Skills
  }
})
export default class App extends Vue {
  // profile
  private characterName = "";
  private occupation = "";
  private remarks = "";
  // status
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
    fixPoint: 0
  };
  // skill point
  private sumOccupationPoint = 0;
  private sumInterestPoint = 0;
  // snackbar status
  private snackbarStatus = {
    snackbar: false,
    text: "dice rolled.",
    timeout: 2000,
  };

  get damageBonus() {
    return checkDamageBonus(Number(this.status.str) + Number(this.status.siz));
  }
  get currentSanValue() {
    return Number(this.status.pow)*5+Number(this.fixStatus.san);
  }
  get currentHPValue() {
    return Math.ceil((Number(this.status.con) + Number(this.status.siz)) / 2)+Number(this.fixStatus.hp);
  }
  get currentMPValue() {
    return Number(this.status.pow) + Number(this.fixStatus.mp);
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

<style scoped>
table {
  background-color: white;
  border-collapse: collapse;
  position: fixed;
  bottom: 0;
  right: 0;
}

table th, table td {
  width: 10rem;
  border: solid 1px;
}

table td {
  text-align: right;
}

.input-status {
  position: relative;
  box-sizing:border-box;
  font-size: 1.5rem;
  text-align: right;
  width: 4rem;
}

.non-input-status {
  margin-right: 1rem;
  font-size: 1.5rem;
  text-align: right;
}
</style>