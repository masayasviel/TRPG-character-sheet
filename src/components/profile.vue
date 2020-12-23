<template>
  <v-container>
    <h1>プロフィール</h1>
    <v-form>
      <v-text-field
        label="character name"
        outlined
        v-model="characterName"
        hint="キャラクター名"
      ></v-text-field>
      <v-text-field
        label="occupation"
        outlined
        v-model="occupation"
        hint="職業"
      ></v-text-field>
      <v-textarea
        outlined
        clearable
        clear-icon="mdi-close-circle"
        label="remarks"
        v-model="remarks"
        hint="備考"
      ></v-textarea>
    </v-form>
  </v-container>
</template>

<script lang="ts">
import { Vue, Component, PropSync } from "vue-property-decorator";
@Component
export default class Profile extends Vue {
  @PropSync("propsCharacterName", {type: String, default: ""})
  private characterName!: string;
  @PropSync("propsOccupation", {type: String, default: ""})
  private occupation!: string;
  @PropSync("propsRemarks", {type: String, default: ""})
  private remarks!: string;
}
</script>

<style scoped>
h1 {
  margin-bottom: 1.5rem;
}
</style>