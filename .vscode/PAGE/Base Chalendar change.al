pageextension 50121 BaseChalendarChange extends "Base Calendar Changes"
{


    layout
    {
        addafter(Nonworking)
        {
            field("Paid Holiday"; "Paid Holiday")
            {
                trigger OnValidate()
                begin
                    Question := Text000;
                    if "Paid Holiday" then
                        Answer := Dialog.Confirm(Question, true);
                end;

            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        Question: Text;
        Text000: Label 'Do you want to set paid holiday for all employees?';
        Answer: Boolean;
}