<template>
  <v-container>

    <!-- ステータスヘッダー -->
    <div class="status-header">
      <h1>ステータス</h1>
      <v-tooltip top>
        <template v-slot:activator="{ on, attrs }">
          <span v-bind="attrs" v-on="on"><img src="../assets/dice.svg" @click="diceRollStatus"></span>
        </template>
        <span>ステータスのダイスロールを一括で行います</span>
      </v-tooltip>
    </div>

    <!-- ステータステーブル -->
    <table>
      <thead>
        <tr>
          <th></th>
          <th v-for="(_, key) in statusMessage" :key="key">
            <v-tooltip top>
              <template v-slot:activator="{ on, attrs }">
                <span v-bind="attrs" v-on="on">{{ key.toUpperCase() }}</span>
              </template>
              <span>{{ statusMessage[key] }}</span>
            </v-tooltip>
          </th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <th class="table-lang-ja">能力値</th>
          <td v-for="(value, key) in status" :key="key">
            <input type="number" v-model="status[key]" class="input-status" max="300" min="-99">
          </td>
          <td><span class="non-input-status">{{ hp() }}</span></td>
          <td><span class="non-input-status">{{ mp() }}</span></td>
          <td><span class="non-input-status">{{ san() }}</span></td>
          <td><span class="non-input-status">{{ idea() }}</span></td>
          <td><span class="non-input-status">{{ lucky() }}</span></td>
          <td><span class="non-input-status">{{ knowledge() }}</span></td>
        </tr>
        <tr>
          <th class="table-lang-ja">修正値</th>
          <td v-for="(value, key) in fixStatus" :key="key">
            <input type="number" v-model="fixStatus[key]" class="input-status" max="300" min="-99">
          </td>
        </tr>
        <tr>
          <th class="table-lang-ja">合計値</th>
          <td v-for="(_, key) in status" :key="key">
            <span class="non-input-status">{{ Number(status[key])+Number(fixStatus[key]) }}</span>
          </td>
          <td><span class="non-input-status">{{ hp(true) }}</span></td>
          <td><span class="non-input-status">{{ mp(true) }}</span></td>
          <td><span class="non-input-status">{{ san(true) }}</span></td>
          <td><span class="non-input-status">{{ idea(true) }}</span></td>
          <td><span class="non-input-status">{{ lucky(true) }}</span></td>
          <td><span class="non-input-status">{{ knowledge(true) }}</span></td>
        </tr>
      </tbody>
    </table>
  </v-container>
</template>

<script lang="ts">
import { Vue, Component, PropSync, Emit } from "vue-property-decorator";

interface StatusType {
  str: number;
  con: number;
  siz: number;
  int: number;
  pow: number;
  dex: number;
  app: number;
  edu: number;
}

interface FixStatusType {
  str: number;
  con: number;
  siz: number;
  int: number;
  pow: number;
  dex: number;
  app: number;
  edu: number;
  hp: number;
  mp: number;
  san: number;
  idea: number;
  lucky: number;
  knowledge: number;
}

@Component
export default class Profile extends Vue {
    @PropSync("propsStatus")
    private status!: StatusType;
    @PropSync("propsFixStatus")
    private fixStatus!: FixStatusType;

    private statusMessage = {
      str: "筋力(1D3)",
      con: "体力(1D3)",
      siz: "体格(2D6+6)",
      int: "知性(2D6+6)",
      pow: "精神力(1D3)",
      dex: "敏捷性(1D3)",
      app: "外見(1D3)",
      edu: "教育(3D6+3)",
      hp: "耐久力(ceil((CON+SIZ)/2))",
      mp: "マジックポイント(POW)",
      san: "正気度(POW×5)",
      idea: "アイディア(INT×5)",
      lucky: "幸運(POW×5)",
      knowledge: "知識(EDU×5)",
    };

    get hp() {
      return (flag = false): number => Math.ceil((Number(this.status.con) + Number(this.status.siz)) / 2) + (flag ? Number(this.fixStatus.hp) : 0);
    }
    get mp() {
      return (flag = false): number => Number(this.status.pow) + (flag ? Number(this.fixStatus.mp) : 0);
    }
    get san() {
      return (flag = false): number => Number(this.status.pow) * 5 + (flag ? Number(this.fixStatus.san) : 0);
    }
    get idea() {
      return (flag = false): number => Number(this.status.int) * 5 + (flag ? Number(this.fixStatus.idea) : 0);
    }
    get lucky() {
      return (flag = false): number => Number(this.status.pow) * 5 + (flag ? Number(this.fixStatus.lucky) : 0);
    }
    get knowledge() {
      return (flag = false): number => Number(this.status.edu) * 5 + (flag ? Number(this.fixStatus.knowledge) : 0);
    }

    @Emit("diceRollStatus")
    private diceRollStatus() { return; }
}
</script>

<style scoped>
.status-header {
  display: flex;
  align-items: center;
  margin-bottom: 1.5rem;;
}

.status-header img {
  width: 4.5rem;
  height: auto;
  margin-left: 1.5rem;
}

.status-header img:hover {
  background-color: lightgray;
  border: solid 2px;
  border-radius: 10%;
}

table {
  border-collapse: collapse;
}

table th, table td {
  border: solid 1px;
}

table td {
  text-align: right;
}

.table-lang-ja {
  white-space: nowrap;
}

.input-status {
  position: relative;
  box-sizing:border-box;
  width: 5rem;
  font-size: 1.5rem;
  text-align: right;
}

.non-input-status {
  margin-right: 1rem;
  width: 5rem;
  font-size: 1.5rem;
  text-align: right;
}
</style>