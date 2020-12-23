<template>
  <v-container>
    <h1>ステータス</h1>
    <table>
      <thead>
        <tr>
          <th></th>
          <th v-for="(value, key) in status" :key="key">
            <v-tooltip top>
              <template v-slot:activator="{ on, attrs }">
                <span
                  v-bind="attrs"
                  v-on="on"
                >{{ key.toUpperCase() }}</span>
              </template>
              <span>{{ statusMessage[key] }}</span>
            </v-tooltip>
          </th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <th>STATUS</th>
          <td v-for="(value, key) in status" :key="key">
            <input type="number" :value="value" class="input-status" max="999" min="-99">
          </td>
        </tr>
      </tbody>
    </table>
  </v-container>
</template>

<script lang="ts">
import { Vue, Component, Prop } from "vue-property-decorator";

interface StatusType {
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
    @Prop()
    private status!: StatusType;

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
      knowledge: "知識(EDU×5)"
    };
}
</script>

<style scoped>
table {
  border-collapse: collapse;
}

table th, table td {
  border: solid 1px;
}

table td {
  text-align: right;
}

.input-status {
  position: relative;
  box-sizing:border-box;
  width: 5rem;
  font-size: 1.5rem;
  text-align: right;
}
</style>