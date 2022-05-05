pageextension 50132 InventorySetup extends "Inventory Setup"
{
    layout
    {
        // Add changes to page layout here
        addafter("Prevent Negative Inventory")
        {
            field("Post Neg. Transfers as Corr."; "Post Neg. Transfers as Corr.")
            {
                ApplicationArea = All;
            }
            field("Post Exp. Cost Conv. as Corr."; "Post Exp. Cost Conv. as Corr.")
            {
                ApplicationArea = All;
            }

        }
    }

}