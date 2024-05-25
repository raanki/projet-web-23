<script setup>
import chartInfo from '@images/cards/chart-info.png'
import creditCardSuccess from '@images/cards/credit-card-success.png'
import creditCardWarning from '@images/cards/credit-card-warning.png'
import paypalError from '@images/cards/paypal-error.png'
import walletPrimary from '@images/cards/wallet-primary.png'

const loans = [
  {
    id: 'L001',
    equipment: 'Laptop HP ProBook',
    student: 'John Doe',
    startDate: '2023-01-01',
    dueDate: '2023-01-31',
    status: 'On time',
    icon: walletPrimary,
    color: 'success',
  },
  {
    id: 'L002',
    equipment: 'Projector Sony XZ2',
    student: 'Emily Stone',
    startDate: '2023-02-15',
    dueDate: '2023-03-15',
    status: 'Late',
    icon: walletPrimary,
    color: 'error',
  },
];

const moreList = [
  {
    title: 'Extend Due Date',
    value: 'Extend',
  },
  {
    title: 'Check Status',
    value: 'Check',
  },
  {
    title: 'Return Equipment',
    value: 'Return',
  },
];
</script>

<template>
  <VCard title="Latest Equipment Loans">
    <template #append>
      <div class="me-n3 mt-n2">
        <MoreBtn :menu-list="moreFilterList" />
      </div>
    </template>

    <VCardText>
      <VList class="loan-list">
        <VListItem
          v-for="loan in loans"
          :key="loan.id"
          style="margin-top: 10px !important;"
        >
          <template #prepend>
            <VAvatar
              rounded
              variant="tonal"
              :color="loan.color"
              :image="loan.icon"
              class="me-3"
            />
          </template>

          <VListItemSubtitle class="text-disabled mb-1">
            {{ loan.student }} - {{ loan.equipment }}
          </VListItemSubtitle>
          <VListItemTitle>
            Start: {{ loan.startDate }} | Due: {{ loan.dueDate }}
          </VListItemTitle>

          <template #append>
            <VListItemAction>
              <span :class="{'text-success': loan.status === 'On time', 'text-error': loan.status === 'Late'}">
                {{ loan.status }}
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


<style lang="scss" scoped>
  .card-list {
    --v-card-list-gap: 1.6rem;
  }
</style>
