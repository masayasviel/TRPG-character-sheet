<template>
  <v-app>
    <Profile
      :propsCharacterName.sync="characterName"
      :propsOccupation.sync="occupation"
      :propsRemarks.sync="remarks"
    />
    <Status
      :status="status"
    />
  </v-app>
</template>

<script lang="ts">
import Vue from "vue";
import Profile from "./components/profile.vue";
import Status from "./components/status.vue";

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

export default Vue.extend({
  name: "App",
  components: {
    Profile,
    Status
  },
  data: () => ({
    // profile
    characterName: "",
    occupation: "",
    remarks: "",
    // status
    status: {
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
    },
  }),
  methods: {
    /**
     * キャラのステータスを決定する
     */
    randomlyDetermineStatus() {
      this.status.str = dice(3, 6);
      this.status.con = dice(3, 6);
      this.status.pow = dice(3, 6);
      this.status.dex = dice(3, 6);
      this.status.app = dice(3, 6);
      this.status.siz = dice(2, 6) + 6;
      this.status.int = dice(2, 6) + 6;
      this.status.edu = dice(3, 6) + 3;
      this.status.hp = Math.ceil((this.status.con + this.status.siz) / 2);
      this.status.mp = this.status.pow;
      this.status.san = this.status.pow * 5;
      this.status.idea = this.status.int * 5;
      this.status.lucky = this.status.pow * 5;
      this.status.knowledge = this.status.edu * 5;
    }
  }
});
</script>
