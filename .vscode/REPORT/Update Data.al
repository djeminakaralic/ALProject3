report 50041 "Update Data"
{
    UsageCategory = Administration;
    ApplicationArea = All;

    dataset
    {
        dataitem(DataItemName; "Position Menu")
        {

        }
    }


    requestpage
    {



        trigger OnAfterGetRecord()
        begin
            if PosM.Get(DataItemName.Code, DataItemName.Description, DataItemName."Department Code", DataItemName."Org. Structure")
            then
                PosM.Rename('RM' + DataItemName.Code, DataItemName.Description, DataItemName."Department Code", DataItemName."Org. Structure");

        end;
    }

    var
        myInt: Integer;
        PosM: Record "Position Menu";

}