<template>

  <span id="title">Create an Equipment 🖥</span>

  <VForm @submit.prevent="submitForm" style="margin-top: 30px !important;">
    <VRow>
      <!-- Nom de l'équipement -->
      <VCol cols="12" md="6">
        <VTextField v-model="equipment.name" label="Equipment Name" placeholder="Enter equipment name" />
      </VCol>

      <!-- Description de l'équipement -->
      <VCol cols="12" md="6">
        <VTextField v-model="equipment.description" label="Description" placeholder="Enter description" type="textarea" />
      </VCol>

      <!-- Date d'achat -->
      <VCol cols="12" md="6">
        <VTextField v-model="equipment.purchaseDate" label="Purchase Date" type="date" />
      </VCol>

      <!-- Prix d'achat -->
      <VCol cols="12" md="6">
        <VTextField v-model="equipment.purchasePrice" label="Purchase Price" prefix="€" type="number" />
      </VCol>

      <!-- Fournisseur -->
      <VCol cols="12" md="6">
        <VTextField v-model="equipment.supplier" label="Supplier" placeholder="Enter supplier name" />
      </VCol>

      <!-- Disponibilité -->
      <VCol cols="12" md="6">
        <VSwitch v-model="equipment.availability" label="Availability" />
      </VCol>
    </VRow>

    <VRow class="d-flex gap-4">
      <VBtn type="submit">Submit</VBtn>
      <VBtn type="reset" color="secondary" variant="tonal">Reset</VBtn>
    </VRow>
  </VForm>
</template>

<script setup>
import { ref } from 'vue'
import { VForm, VRow, VCol, VTextField, VSwitch, VBtn } from 'vuetify/components'

const equipment = ref({
  name: '',
  description: '',
  purchaseDate: '',
  purchasePrice: '',
  supplier: '',
  availability: false
})

function submitForm() {
  // Logique de soumission de formulaire
  console.log("Equipment submitted with:", equipment.value)
}
</script>

<style scoped>
#title {
  font-size: 2rem;
  color: black;
  font-weight: bold;
  margin-bottom: 20px !important;
}
</style>
