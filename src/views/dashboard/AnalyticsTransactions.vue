<script setup>
import walletPrimary from '@images/cards/wallet-primary.png'
import { ref, onMounted } from 'vue'
import { API_URL } from '/src/env'
import dayjs from 'dayjs'

const latestEquipmentLoans = ref([])

const formatDate = (dateStr) => {
  return dayjs(dateStr).format('DD/MM/YYYY')
}

const fetchData = async () => {
  try {
    const response = await fetch(API_URL + 'api/dashboard')
    const data = await response.json()

    latestEquipmentLoans.value = data.latestEquipmentLoans
  } catch (error) {
    console.error('Error fetching data:', error)
  }
}

onMounted(() => {
  fetchData()
})
</script>

<template>
  <VCard title="Latest Equipment Loans">
    <VCardText>
      <VList class="loan-list">
        <VListItem
          v-for="loan in latestEquipmentLoans"
          :key="loan.id"
          style="margin-top: 10px !important;"
        >
          <template #prepend>
            <VAvatar
              rounded
              variant="tonal"
              :color="loan.expect_end_date < loan.actual_end_date ? 'error' : 'success'"
              :image="walletPrimary"
              class="me-3"
            />
          </template>
          <VListItemSubtitle class="text-disabled mb-1">
            {{ loan.student_name }} - {{ loan.equipment_name }}
          </VListItemSubtitle>
          <VListItemTitle>
            Start: {{ formatDate(loan.start_date) }} | Due: {{ formatDate(loan.expect_end_date) }}
          </VListItemTitle>
          <template #append>
            <VListItemAction>
              <span :class="{'text-success': loan.expect_end_date >= loan.actual_end_date, 'text-error': loan.expect_end_date < loan.actual_end_date}">
                {{
                  loan.expect_end_date < loan.actual_end_date ? 'Late' : (loan.actual_end_date === null ? 'On going' : 'On time')
                }}
              </span>
            </VListItemAction>
          </template>
        </VListItem>
      </VList>
    </VCardText>
  </VCard>
</template>

<style lang="scss" scoped>
.loan-list {
  --v-list-gap: 1.6rem;
}
</style>
