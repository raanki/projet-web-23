<template>
  <span id="title">{{ formTitle }}</span>
  <VForm @submit.prevent="submitForm" style="margin-top: 30px !important;">
    <VRow>
      <!-- Nom de l'équipement -->
      <VCol cols="12" md="6">
        <VTextField v-model="equipment.name" :label="labels.name" placeholder="Enter equipment name" :disabled="isViewMode" />
      </VCol>
      <!-- Description de l'équipement -->
      <VCol cols="12" md="6">
        <VTextField v-model="equipment.description" :label="labels.description" placeholder="Enter description" type="textarea" :disabled="isViewMode" />
      </VCol>
      <!-- Date d'achat -->
      <VCol cols="12" md="6">
        <VTextField v-model="equipment.purchaseDate" :label="labels.purchaseDate" type="date" :disabled="isViewMode"/>
      </VCol>
      <!-- Prix d'achat -->
      <VCol cols="12" md="6">
        <VTextField v-model="equipment.purchasePrice" :label="labels.purchasePrice" prefix="$" type="number"
                    :disabled="isViewMode"/>
      </VCol>
      <!-- Fournisseur -->
      <VCol cols="12" md="6">
        <VTextField v-model="equipment.supplier" :label="labels.supplier" placeholder="Enter supplier name"
                    :disabled="isViewMode"/>
      </VCol>
      <!-- Disponibilité -->
      <VCol cols="12" md="6">
        <VSwitch v-model="equipment.availability" :label="labels.availability" :disabled="isViewMode"/>
      </VCol>
    </VRow>
    <VRow class="d-flex gap-4" style="margin-top: 40px !important;">
      <VBtn v-if="!isViewMode" type="submit">Submit</VBtn>
      <VBtn v-if="!isViewMode" type="reset" color="secondary" variant="tonal">Reset</VBtn>
    </VRow>
  </VForm>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { useRoute, useRouter } from 'vue-router'
import { VForm, VRow, VCol, VTextField, VSwitch, VBtn } from 'vuetify/components'
import { defineProps } from 'vue'

const props = defineProps({
  action: String,
  id: String,
})

const route = useRoute()
const router = useRouter()

const equipment = ref({
  name: '',
  description: '',
  purchaseDate: '',
  purchasePrice: '',
  supplier: '',
  availability: false
})

const labels = {
  name: 'Equipment Name',
  description: 'Description',
  purchaseDate: 'Purchase Date',
  purchasePrice: 'Purchase Price',
  supplier: 'Supplier',
  availability: 'Availability'
}

const formTitle = ref('')
const isViewMode = ref(false)

onMounted(() => {
  const action = props.action
  const equipmentId = props.id

  if (action === 'edit') {
    formTitle.value = 'Edit equipment ✏️'
    fetchEquipmentById(equipmentId).then(data => equipment.value = data)
  } else if (action === 'view') {
    formTitle.value = 'View equipment 👁️'
    isViewMode.value = true
    fetchEquipmentById(equipmentId).then(data => equipment.value = data)
  } else {
    formTitle.value = 'Create an equipment 🖥️'
  }
})

function fetchEquipmentById(id) {
  return new Promise(resolve => {
    setTimeout(() => {
      resolve({
        name: 'Sample Equipment',
        description: 'Sample Description',
        purchaseDate: '2023-01-01',
        purchasePrice: 1000,
        supplier: 'Sample Supplier',
        availability: true
      })
    }, 1000)
  })
}

function submitForm() {
  if (isViewMode.value) return
  // Logique de soumission de formulaire
  console.log("Equipment submitted with:", equipment.value)
}
</script>

<style scoped>
#title {
  font-size: 2rem;
  font-style: italic;
  color: #6F72FF;
  font-weight: bold;
  margin-bottom: 20px !important;
}
</style>
