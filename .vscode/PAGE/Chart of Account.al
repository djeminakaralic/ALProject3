pageextension 50104 "G/L Account Card" extends "G/L Account Card"
{
    layout
    {
        // Add changes to page layout here
        modify("Account Category")
        { Visible = false; }
        modify(SubCategoryDescription)
        { Visible = false; }
        modify("No. of Blank Lines")
        { Visible = false; }
        modify("Reconciliation Account")
        {
            Visible = false;
        }
        modify("Automatic Ext. Texts")
        {
            Visible = false;
        }
        modify("Omit Default Descr. in Jnl.")
        { Visible = false; }
        modify("Tax Group Code")
        { Visible = false; }
        modify("Default IC Partner G/L Acc. No")
        {
            Visible = false;
        }
        modify("Default Deferral Template Code")
        { Visible = false; }
        modify(Consolidation) { Visible = false; }
        modify("Cost Accounting")
        { Visible = false; }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}