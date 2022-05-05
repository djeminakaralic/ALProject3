tableextension 50101 salesLineExtends extends "Sales Line"
{

    fields
    {
        //    VAT Base (retro.)
        field(50000; "G/L Correction"; Boolean)
        {

            DataClassification = ToBeClassified;

        }

        field(50001; "Manufacturer Code"; Code[20])
        {

            DataClassification = ToBeClassified;

        }
    }
}