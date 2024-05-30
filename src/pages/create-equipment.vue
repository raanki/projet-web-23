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
        <VTextField v-model="equipment.purchasePrice" :label="labels.purchasePrice" prefix="$" type="number" :disabled="isViewMode"/>
      </VCol>
      <!-- Fournisseur -->
      <VCol cols="12" md="6">
        <VTextField v-model="equipment.supplier" :label="labels.supplier" placeholder="Enter supplier name" :disabled="isViewMode"/>
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
import { API_URL } from '/src/env'

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

async function fetchEquipmentById(id) {
  try {
    const response = await fetch(`${API_URL}api/equipment`, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({
        action: 'fetch',
        id: id,
      }),
    });
    if (!response.ok) {
      throw new Error('Network response was not ok');
    }
    const data = await response.json();
    return data;
  } catch (error) {
    console.error('Error fetching equipment:', error);
    return {
      name: '',
      description: '',
      purchaseDate: '',
      purchasePrice: '',
      supplier: '',
      availability: false
    };
  }
}

async function updateEquipment(equipmentData) {
  try {
    const response = await fetch(`${API_URL}api/equipment`, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({
        action: 'update',
        ...equipmentData,
      }),
    });
    if (!response.ok) {
      throw new Error('Network response was not ok');
    }
    const data = await response.json();
    return data;
  } catch (error) {
    console.error('Error updating equipment:', error);
    return {
      error: 'Failed to update equipment'
    };
  }
}

async function createEquipment(equipmentData) {
  try {
    const response = await fetch(`${API_URL}api/equipment`, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({
        action: 'create',
        ...equipmentData,
      }),
    });
    if (!response.ok) {
      throw new Error('Network response was not ok ' + response.statusText);
    }
    const data = await response.text();
    try {
      const parsedData = JSON.parse(data);
      console.log('Equipment created:', parsedData);
      router.push('/equipment');
    } catch (err) {
      console.error('Failed to parse JSON:', err, data);
    }
  } catch (error) {
    console.error('Error:', error);
  }
}

function submitForm() {
  if (isViewMode.value) return;

  if (props.action === 'edit') {
    updateEquipment(equipment.value).then(response => {
      if (!response.error) {
        router.push('/equipment');
      } else {
        console.error(response.error);
      }
    });
  } else {
    createEquipment(equipment.value);
  }
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
