tableextension 50123 TransferHeaderExtends extends "Transfer Header"
{

    fields
    {
        //    VAT Base (retro.)
        field(50000; "Gen. Bus. Posting Group"; Decimal)
        {

            DataClassification = ToBeClassified;
            TableRelation = "Gen. Business Posting Group";

        }

    }
}