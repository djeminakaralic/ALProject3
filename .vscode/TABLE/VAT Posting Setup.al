tableextension 50122 VATPostingSetupExtends extends "VAT Posting Setup"
{

    fields
    {
        //    VAT Base (retro.)
        field(50000; "VAT % (retrograde)"; Decimal)
        {

            DataClassification = ToBeClassified;

        }

        field(50001; "VAT % (inf.)"; Decimal)
        {

            DataClassification = ToBeClassified;

        }

    }
}