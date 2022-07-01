pageextension 50130 ItemJournalBatches extends "Item Journal Batches"
{
    layout
    {
        // Add changes to page layout here
        addafter(Description)
        {
            field("Gen. Bus. Posting Group"; "Gen. Bus. Posting Group")
            {
                ApplicationArea = All;
                //nermina
            }
        }
    }
}
