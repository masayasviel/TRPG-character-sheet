<template>
  <v-container>
    <h1>技能</h1>
    <h2>計算法が特殊な技能</h2>
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
        <tr>
          <th>{{ avoidance.name }}</th>
          <td><span class="non-input-status">{{ avoidanceInitValue }}</span></td>
          <td><input type="number" v-model="avoidance.occupationPoint" class="input-status" max="300" min="-99"></td>
          <td><input type="number" v-model="avoidance.interestPoint" class="input-status" max="300" min="-99"></td>
          <td><input type="number" v-model="avoidance.fixPoint" class="input-status" max="300" min="-99"></td>
          <td><span class="non-input-status">{{ sumPoint("avoidance") }}</span></td>
        </tr>
        <tr>
          <th>{{ nativeLanguage.name }}</th>
          <td><span class="non-input-status">{{ nativeLanguageInitValue }}</span></td>
          <td><input type="number" v-model="nativeLanguage.occupationPoint" class="input-status" max="300" min="-99"></td>
          <td><input type="number" v-model="nativeLanguage.interestPoint" class="input-status" max="300" min="-99"></td>
          <td><input type="number" v-model="nativeLanguage.fixPoint" class="input-status" max="300" min="-99"></td>
          <td><span class="non-input-status">{{ sumPoint("nativeLanguage") }}</span></td>
        </tr>
      </tbody>
    </table>
    <h2>知識技能</h2>
    <skillsTable
      :category="'academic'"
      :propSkillTable.sync="academicList"
    />
    <h2>行動技能</h2>
    <skillsTable
      category="action"
      :propSkillTable.sync="actionList"
    />
    <h2>戦闘技能</h2>
    <skillsTable
      category="combat"
      :propSkillTable.sync="combatList"
    />
    <h2>交渉技能</h2>
    <skillsTable
      category="negotiate"
      :propSkillTable.sync="negotiateList"
    />
    <h2>探索技能</h2>
    <skillsTable
      category="search"
      :propSkillTable.sync="searchList"
    />
    <h2>その他技能</h2>
    <EtceteraSkillTable
      :propSkillTable.sync="etceteraList"
      @appendEmit="append"
      @declearEmit=declear
    />
  </v-container>
</template>

<script lang="ts">
import { Vue, Component, PropSync } from "vue-property-decorator";

import skillsTable from "@/components/skillTable.vue";
import EtceteraSkillTable from "@/components/etceteraSkillTable.vue";
import skillsTableJSON from "@/assets/skills.json";

interface SkillsType {
  name: string;
  initValue: number;
  occupationPoint: number;
  interestPoint: number;
  fixPoint: number;
}

@Component({
  components: {
    skillsTable,
    EtceteraSkillTable
  }
})
export default class Skills extends Vue {
  @PropSync("propEDU")
  private edu!: number;
  @PropSync("propDEX")
  private dex!: number;

  // skills list
  private nativeLanguage = {
    name: "母国語",
    initValue: 0,
    occupationPoint: 0,
    interestPoint: 0,
    fixPoint: 0
  };
  private avoidance = {
    name: "回避",
    initValue: 0,
    occupationPoint: 0,
    interestPoint: 0,
    fixPoint: 0
  };
  private academicList = skillsTableJSON.academic;
  private actionList = skillsTableJSON.action;
  private combatList = skillsTableJSON.combat;
  private negotiateList = skillsTableJSON.negotiate;
  private searchList = skillsTableJSON.search;
  private etceteraList: SkillsType[] = [];

  get nativeLanguageInitValue() {
    this.nativeLanguage.initValue = Number(this.edu) * 5;
    return this.nativeLanguage.initValue;
  }
  get avoidanceInitValue() {
    this.avoidance.initValue = Number(this.dex) * 2;
    return this.avoidance.initValue;
  }
  get sumPoint() {
    return (s: string): number => {
      let res = 0;
      switch (s) {
        case "avoidance":
          res = Number(this.avoidance.initValue) + Number(this.avoidance.occupationPoint) + 
                Number(this.avoidance.interestPoint) + Number(this.avoidance.fixPoint);
          break;
        case "nativeLanguage":
          res = Number(this.nativeLanguage.initValue) + Number(this.nativeLanguage.occupationPoint) + 
                Number(this.nativeLanguage.interestPoint) + Number(this.nativeLanguage.fixPoint);
          break;
      }
      return res;
    }
  }

  /**
   * その他技能に新しい行を追加
   */
  private append() {
    if (this.etceteraList.length < 10) {
      this.etceteraList.push({
        name: "sample",
        initValue: 0,
        occupationPoint: 0,
        interestPoint: 0,
        fixPoint: 0
      });
    }
  }

  /**
   * その他技能の最後の行を削除
   */
  private declear() {
    if(this.etceteraList.length != 0) {
      this.etceteraList.pop();
    }
  }
}
</script>

<style scoped>
h1 {
  margin-bottom: 1.5rem;
}

h2 {
  margin: 1.5rem;
}

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