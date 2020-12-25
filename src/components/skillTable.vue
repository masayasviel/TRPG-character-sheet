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
        <tr v-for="(skill, index) in skillTable" :key="category+index">
          <th>{{ skill.name }}</th>
          <td><span class="non-input-status">{{ skill.initValue }}</span></td>
          <td><input type="number" v-model="skill.occupationPoint" class="input-status" max="300" min="-99"></td>
          <td><input type="number" v-model="skill.interestPoint" class="input-status" max="300" min="-99"></td>
          <td><input type="number" v-model="skill.fixPoint" class="input-status" max="300" min="-99"></td>
          <td><span class="non-input-status">{{ skill.interestPoint }}</span></td>
        </tr>
      </tbody>
    </table>
  </v-container>
</template>

<script lang="ts">
import { Vue, Component, Prop, PropSync } from "vue-property-decorator";
import { PropType } from "vue"

interface SkillsType {
  name: string;
  initValue: number;
  occupationPoint: number;
  interestPoint: number;
  fixPoint: number;
}

@Component
export default class SkillTable extends Vue {
  @PropSync("propSkillTable", { type: Array as PropType<SkillsType[]>, default: [] })
  private skillTable!: SkillsType[];
  @Prop()
  private category!: string;
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
</style>