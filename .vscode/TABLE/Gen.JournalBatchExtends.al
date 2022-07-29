tableextension 50217 GenJournalBatch extends "Gen. Journal Batch"
{
    fields
    {

        field(50001; "Cashier Table"; Code[10])
        {
            Caption = 'Cashier Table';
            TableRelation = Cashier;

        }
    }
}