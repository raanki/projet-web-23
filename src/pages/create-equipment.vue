<template>
  <span id="title">{{ formTitle }}</span>
  <VForm @submit.prevent="submitForm" ref="form" style="margin-top: 30px !important;">
    <VRow>
      <!-- Nom de l'équipement -->
      <VCol cols="12" md="6">
        <VTextField
          v-model="equipment.name"
          :label="labels.name"
          placeholder="Enter equipment name"
          :disabled="isViewMode"
          :rules="[v => !!v || 'Name is required']"
          ref="name"
          class="required-field"
        />
      </VCol>
      <!-- Description de l'équipement -->
      <VCol cols="12" md="6">
        <VTextField
          v-model="equipment.description"
          :label="labels.description"
          placeholder="Enter description"
          type="textarea"
          :disabled="isViewMode"
          :rules="[v => !!v || 'Description is required']"
          ref="description"
        />
      </VCol>
      <!-- Date d'achat -->
      <VCol cols="12" md="6">
        <VTextField
          v-model="equipment.purchaseDate"
          :label="labels.purchaseDate"
          type="date"
          :disabled="isViewMode"
          :rules="[v => !!v || 'Purchase date is required']"
          ref="purchaseDate"
        />
      </VCol>
      <!-- Prix d'achat -->
      <VCol cols="12" md="6">
        <VTextField
          v-model="equipment.purchasePrice"
          :label="labels.purchasePrice"
          prefix="$"
          type="number"
          :disabled="isViewMode"
          :rules="[v => !!v || 'Purchase price is required']"
          ref="purchasePrice"
        />
      </VCol>
      <!-- Fournisseur -->
      <VCol cols="12" md="6">
        <VTextField
          v-model="equipment.supplier"
          :label="labels.supplier"
          placeholder="Enter supplier name"
          :disabled="isViewMode"
          :rules="[v => !!v || 'Supplier is required']"
          ref="supplier"
        />
      </VCol>
      <!-- Disponibilité -->
      <VCol cols="12" md="6">
        <VSwitch
          v-model="equipment.availability"
          :label="labels.availability"
          :disabled="isViewMode"
          :rules="[v => v !== null || 'Availability is required']"
          ref="availability"
        />
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

// Define refs for each field
const nameRef = ref(null)
const descriptionRef = ref(null)
const purchaseDateRef = ref(null)
const purchasePriceRef = ref(null)
const supplierRef = ref(null)
const availabilityRef = ref(null)

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

  if (equipmentData.value === undefined) {
    equipmentData.value = {};
  }

  if (equipmentData.value.availability === undefined) {
    console.log("set availability");
    equipmentData.value.availability = "0";
  }
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
      console.log("data => ", data);
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

  let isValid = true;

  // Check each field for validity
  if (!equipment.value.name) isValid = false;
  if (!equipment.value.description) isValid = false;
  if (!equipment.value.purchaseDate) isValid = false;
  if (!equipment.value.purchasePrice) isValid = false;
  if (!equipment.value.supplier) isValid = false;
  if (equipment.value.availability === null) equipment.value.availability  = false;

  console.log(isValid);
  if (!isValid) return;

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

.required-field .v-label {
  color: red !important;
}

.required-field .v-input__control {
  border-color: red !important;
}
</style>
