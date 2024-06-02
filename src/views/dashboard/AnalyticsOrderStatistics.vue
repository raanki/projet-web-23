<script setup>
import VueApexCharts from 'vue3-apexcharts'
import { useTheme } from 'vuetify'
import { hexToRgb } from '@layouts/utils'
import { ref, computed, onMounted } from 'vue'
import { API_URL } from '/src/env'

const vuetifyTheme = useTheme()

const popularEquipmentLoans = ref([])
const totalLoan = ref(0)

const fetchData = async () => {
  try {
    const response = await fetch(API_URL + 'api/dashboard')
    const data = await response.json()

    popularEquipmentLoans.value = data.popularEquipmentLoans
    totalLoan.value = data.totalLoan
  } catch (error) {
    console.error('Error fetching data:', error)
  }
}

onMounted(() => {
  fetchData()
})

const chartSeries = computed(() => popularEquipmentLoans.value.map(loan => loan.loan_count))

const chartLabels = computed(() => popularEquipmentLoans.value.map(loan => loan.equipment_name || `Material ${loan.material_id}`))

const chartOptions = computed(() => {
  const currentTheme = vuetifyTheme.current.value.colors
  const variableTheme = vuetifyTheme.current.value.variables
  const disabledTextColor = `rgba(${hexToRgb(String(currentTheme['on-surface']))},${variableTheme['disabled-opacity']})`
  const primaryTextColor = `rgba(${hexToRgb(String(currentTheme['on-surface']))},${variableTheme['high-emphasis-opacity']})`

  return {
    chart: {
      sparkline: { enabled: true },
      animations: { enabled: false },
    },
    stroke: {
      width: 6,
      colors: [currentTheme.surface],
    },
    legend: { show: false },
    tooltip: { enabled: false },
    dataLabels: { enabled: false },
    labels: chartLabels.value,
    colors: [
      currentTheme.success,
      currentTheme.primary,
      currentTheme.secondary,
      currentTheme.info,
      currentTheme.error,
    ],
    grid: {
      padding: {
        top: -7,
        bottom: 5,
      },
    },
    states: {
      hover: {filter: {type: 'none'}},
      active: {filter: {type: 'none'}},
    },
    plotOptions: {
      pie: {
        expandOnClick: false,
        donut: {
          size: '75%',
          labels: {
            show: true,
            name: {
              offsetY: 17,
              fontSize: '14px',
              color: disabledTextColor,
              fontFamily: 'Public Sans',
            },
            value: {
              offsetY: -17,
              fontSize: '24px',
              color: primaryTextColor,
              fontFamily: 'Public Sans',
            },
            total: {
              show: true,
              label: 'Total',
              fontSize: '14px',
              formatter: () => `${totalLoan.value}`,
              color: disabledTextColor,
              fontFamily: 'Public Sans',
            },
          },
        },
      },
    },
  }
})
</script>

<template>
  <VCard>
    <VCardItem class="pb-3">
      <VCardTitle class="mb-1">
        Most Popular Equipment Loans
      </VCardTitle>
    </VCardItem>

    <VCardText>
      <div class="d-flex align-center justify-space-between mb-3">
        <div class="flex-grow-1">
          <h4 class="text-h4 mb-1">
            {{ totalLoan }}
          </h4>
          <span>Total Loans</span>
        </div>

        <div v-if="chartSeries.length && chartLabels.length">
          <VueApexCharts
            type="donut"
            :height="125"
            width="105"
            :options="chartOptions"
            :series="chartSeries"
          />
        </div>
        <div v-else>
          Loading chart...
        </div>
      </div>

      <VList class="card-list mt-7">
        <VListItem
          v-for="loan in popularEquipmentLoans"
          :key="loan.material_id"
        >
          <template #prepend>
            <VAvatar
              rounded
              variant="tonal"
              color="primary"
            >
              <VIcon icon="bx-laptop"/>
            </VAvatar>
          </template>

          <VListItemTitle class="mb-1">
            {{ loan.equipment_name || `Material ${loan.material_id}` }}
          </VListItemTitle>
          <VListItemSubtitle class="text-disabled">
            Loaned {{ loan.loan_count }} times
          </VListItemSubtitle>

          <template #append>
            <span>{{ loan.loan_count }}</span>
          </template>
        </VListItem>
      </VList>
    </VCardText>
  </VCard>
</template>

<style lang="scss" scoped>
.card-list {
  --v-card-list-gap: 21px;
}
</style>
