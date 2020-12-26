<template>
  <v-container>
    <table>
      <thead>
        <tr>
          <th>技能名</th>
          <th>初期値</th>
          <th>職業ポイント</th>
          <th>興味ポイント</th>
          <th>修正値</th>
          <th>合計値</th>
        </tr>
      </thead>
      <tbody>
        <tr v-for="(skill, index) in skillTable" :key="'etcetera'+index">
          <th><input type="text" v-model="skill.name" class="input-status"></th>
          <td><input type="number" v-model="skill.initValue" class="input-status" max="300" min="-99"></td>
          <td><input type="number" v-model="skill.occupationPoint" class="input-status" max="300" min="-99"></td>
          <td><input type="number" v-model="skill.interestPoint" class="input-status" max="300" min="-99"></td>
          <td><input type="number" v-model="skill.fixPoint" class="input-status" max="300" min="-99"></td>
          <td><span class="non-input-status">
            {{ (Number(skill.initValue)+Number(skill.occupationPoint)+Number(skill.interestPoint)+Number(skill.fixPoint)) }}
          </span></td>
        </tr>
        <tr>
          <td colspan="3" class="mdi-btn">
            <v-tooltip top>
              <template v-slot:activator="{ on, attrs }">
                <span v-bind="attrs" v-on="on">
                  <v-btn
                    class="mx-2"
                    fab
                    dark
                    color="indigo"
                    @click="appendEmit"
                  >
                    <v-icon dark>mdi-plus</v-icon>
                  </v-btn>
                </span>
              </template>
              <span>新しい行を追加します(10行まで)</span>
            </v-tooltip>
          </td>
          <td colspan="3" class="mdi-btn">
            <v-tooltip top>
              <template v-slot:activator="{ on, attrs }">
                <span v-bind="attrs" v-on="on">
                  <v-btn
                    class="mx-2"
                    fab
                    dark
                    color="pink"
                    @click="declearEmit"
                  >
                    <v-icon dark>mdi-minus</v-icon>
                  </v-btn>
                </span>
              </template>
              <span>一番下の行を削除します</span>
            </v-tooltip>
          </td>
        </tr>
      </tbody>
    </table>
  </v-container>
</template>

<script lang="ts">
import { Vue, Component, PropSync, Emit } from "vue-property-decorator";

interface SkillsType {
  name: string;
  initValue: number;
  occupationPoint: number;
  interestPoint: number;
  fixPoint: number;
}

@Component
export default class SkillTable extends Vue {
  @PropSync("propSkillTable")
  private skillTable!: SkillsType[];

  @Emit("appendEmit")
  private appendEmit() { return; }
  @Emit("declearEmit")
  private declearEmit() { return; }
}
</script>

<style scoped>
table {
  border-collapse: collapse;
}

table th, table td {
  width: 7rem;
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
}

.non-input-status {
  margin-right: 1rem;
  font-size: 1.5rem;
  text-align: right;
}

.mdi-btn {
  text-align: center;
}
</style>