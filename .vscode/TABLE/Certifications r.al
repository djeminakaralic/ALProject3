table 52039 "Certifications r"
{
    // HR01-30.11.2016 HR customization

    Caption = 'Certifications and solutions';
    DataCaptionFields = "Employee No.";
    DrillDownPageID = 5221;
    LookupPageID = 5221;

    fields
    {
        field(1; "Employee No."; Code[20])
        {
            Caption = 'Employee No.';
            NotBlank = true;
            TableRelation = Employee;
        }
        field(50011; "Employee Name"; Text[50])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup(Employee."First Name" WHERE("No." = FIELD("Employee No.")));
            Caption = 'Employee Name';
            Editable = false;

        }
        field(50012; "Employee Last Name"; Text[50])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup(Employee."Last Name" WHERE("No." = FIELD("Employee No.")));
            Caption = 'Employee Last Name';
            Editable = false;

        }
        field(50013; "Date Of Input Info"; Date)
        {
            Caption = 'Date of input information';
        }
        field(50015; "Sector Name"; Text[250])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Employee Contract Ledger"."Sector Description" WHERE("Employee No." = FIELD("Employee No.")));
            Caption = 'Sector';
            Editable = false;

        }
        field(50016; "Group Name"; Text[250])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Employee Contract Ledger"."Group Description" WHERE("Employee No." = FIELD("Employee No.")));
            Caption = 'Group';
            Editable = false;

        }
        field(50017; "Team Name"; Text[250])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Employee Contract Ledger"."Team Description" WHERE("Employee No." = FIELD("Employee No.")));
            Caption = 'Team';
            Editable = false;

        }
        field(50018; "Department Name"; Text[250])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Employee Contract Ledger"."Department Cat. Description" WHERE("Employee No." = FIELD("Employee No.")));
            Caption = 'Department Category Description';
            Editable = false;

        }
        field(50020; "Agreement Code"; Code[30])
        {
            Caption = 'Agreement code';
        }
        field(50021; Group; Option)
        {
            Caption = 'Group';
            FieldClass = Normal;
            OptionCaption = ' ,Certification,Solutions,Decisions';
            OptionMembers = " ",Certification,Solutions,Decisions;
        }
        field(50022; "Document Description"; Text[90])
        {
            Caption = 'Document description';
            TableRelation = "Certication and solu"."Document Description" WHERE(Group = FIELD(Group),
                                                                                 "Show Template" = FILTER(TRUE));

            trigger OnValidate()
            begin
                IF "Document Description" <> '' THEN BEGIN
                    CerAndSol.RESET;
                    CerAndSol.SETFILTER("Document Description", '%1', "Document Description");
                    CerAndSol.SETFILTER("Show Template", '%1', TRUE);
                    IF CerAndSol.FINDFIRST THEN BEGIN
                        "Agreement Code" := CerAndSol."Agreement Code";
                        Group := CerAndSol.Group;
                    END;
                END
                ELSE BEGIN
                    "Agreement Code" := '';
                    Group := 0;
                END;

                /*  CLEAR(Contract5062);
                  CLEAR(Contract5063);
                  CLEAR(Contract5061);
                  CLEAR(Contract88);
                  CLEAR(Contract87);
                  CLEAR(Contract115);
                  CLEAR(Contract129);
                  CLEAR(Contract187);
                  CLEAR(Contract188);
                  CLEAR(Contract189);
                  CLEAR(Contract190);
                  CLEAR(Contract191);
                  CLEAR(Contract192);
                  CLEAR(Contract193);
                  CLEAR(Contract215);
                  CLEAR(Contract216);
                  CLEAR(Contract291);
                  CLEAR(Contract292);
                  CLEAR(Contract296);
                  CLEAR(Contract297);
                  CLEAR(Contract298);
                  CLEAR(Contract319);
                  CLEAR(Contract322);
                  CLEAR(Contract324);
                  CLEAR(Contract406);
                  CLEAR(Contract407);
                  CLEAR(Contract408);
                  CLEAR(Contract410);
                  CLEAR(Contract412);
                  CLEAR(Contract415);
                  CLEAR(Contract416);
                  CLEAR(Contract417);
                  CLEAR(Contract418);
                  CLEAR(Contract491);
                  CLEAR(Contract496);
                  CLEAR(Contract497);
                  CLEAR(Contract498);
                  CLEAR(Contract499);
                  CLEAR(Contract5064);

                  CLEAR(Contract5064);
                  CLEAR(Contract5066);
                  CLEAR(Contract5178);
                  CLEAR(Contract5179);
                  CLEAR(Contract5180);
                  CLEAR(Contract5188);
                  CLEAR(Contract5189);
                  CLEAR(Contract5190);
                  CLEAR(Contract5193);
                  CLEAR(Contract5194);
                  CLEAR(Contract5195);
                  CLEAR(Contract5196);
                  CLEAR(Contract5197);
                  CLEAR(Contract5198);
                  CLEAR(Contract5199);
                  CLEAR(Contract5606);
                  CLEAR(Contract5607);
                  CLEAR(Contract5608);
                  CLEAR(Contract5610);
                  CLEAR(Contract5611);
                  CLEAR(Contract5620);
                  CLEAR(Contract5621);
                  CLEAR(Contract5622);
                  CLEAR(Contract5623);*/
                CLEAR(FileManagement);


                IF CerAndSol."NAV Agreement Code" = 88 THEN BEGIN


                    CRL.SETFILTER("Report ID", '%1', CerAndSol."NAV Agreement Code");
                    IF CRL.FINDLAST THEN BEGIN
                        ReportLayoutSelection.SetTempLayoutSelected(FORMAT(CRL."REPORT ID"));
                        Cert.SETFILTER("Employee No.", '%1', Rec."Employee No.");

                        BrojPotvrda := 0;
                        Cert1.RESET;
                        Cert1.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                        Cert1.SETFILTER(Group, '%1', Rec.Group);
                        IF Cert1.FIND('-') THEN BEGIN
                            BrojPotvrda := Cert1.COUNT;
                        END;
                        //ĐK  Contract88.SetParam("Employee No.",Rec."Agreement Code",0,Rec."Date Of certifications");
                        hr.GET;

                        tempSaveDest := hr."File Path" + "Employee No." + '-' + FORMAT(BrojPotvrda) + '.docx';
                        //ĐK Contract88.SAVEASWORD(tempSaveDest);
                        FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                        IF Attachment.GET("Attachment No.") THEN
                            Attachment.TESTFIELD("Read Only", FALSE);

                        IF "Attachment No." <> 0 THEN BEGIN
                            IF NOT CONFIRM(Text004, FALSE) THEN
                                EXIT;
                            RemoveAttachment(FALSE);
                            "Attachment No." := 0;
                            MODIFY(FALSE);
                            COMMIT;
                        END;

                        NewAttachNo := AttachmentManagement.InsertAttachment("Attachment No.");
                        IF NewAttachNo <> 0 THEN BEGIN
                            "Attachment No." := NewAttachNo;

                            COMMIT;
                        END;


                    END;
                    ImportAttachment;
                END;

                IF CerAndSol."NAV Agreement Code" = 87 THEN BEGIN
                    CRL.SETFILTER("Report ID", '%1', CerAndSol."NAV Agreement Code");
                    IF CRL.FINDLAST THEN BEGIN
                        ReportLayoutSelection.SetTempLayoutSelected(FORMAT(CRL."REPORT ID"));
                        Cert.SETFILTER("Employee No.", '%1', Rec."Employee No.");

                        BrojPotvrda := 0;
                        Cert1.RESET;
                        Cert1.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                        IF Cert1.FIND('-') THEN BEGIN
                            BrojPotvrda := Cert1.COUNT;
                        END;
                        //ĐK Contract87.SetParam("Employee No.",Rec."Agreement Code",0,Rec."Date Of certifications");
                        hr.GET;

                        tempSaveDest := hr."File Path" + "Employee No." + '-' + FORMAT(BrojPotvrda) + '.docx';
                        //ĐK Contract87.SAVEASWORD(tempSaveDest);
                        FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                        IF Attachment.GET("Attachment No.") THEN
                            Attachment.TESTFIELD("Read Only", FALSE);

                        IF "Attachment No." <> 0 THEN BEGIN
                            IF NOT CONFIRM(Text004, FALSE) THEN
                                EXIT;
                            RemoveAttachment(FALSE);
                            "Attachment No." := 0;
                            MODIFY(FALSE);
                            COMMIT;
                        END;

                        NewAttachNo := AttachmentManagement.InsertAttachment("Attachment No.");
                        IF NewAttachNo <> 0 THEN BEGIN
                            "Attachment No." := NewAttachNo;

                            COMMIT;
                        END;


                    END;
                    ImportAttachment;
                END;


                IF CerAndSol."NAV Agreement Code" = 115 THEN BEGIN


                    CRL.SETFILTER("Report ID", '%1', CerAndSol."NAV Agreement Code");
                    IF CRL.FINDLAST THEN BEGIN
                        ReportLayoutSelection.SetTempLayoutSelected(FORMAT(CRL."REPORT ID"));
                        Cert.SETFILTER("Employee No.", '%1', Rec."Employee No.");

                        BrojPotvrda := 0;
                        Cert1.RESET;
                        Cert1.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                        IF Cert1.FIND('-') THEN BEGIN
                            BrojPotvrda := Cert1.COUNT;
                        END;
                        //ĐK    Contract115.SetParam("Employee No.",Rec."Agreement Code",0,Rec."Date Of certifications");
                        hr.GET;

                        tempSaveDest := hr."File Path" + "Employee No." + '-' + FORMAT(BrojPotvrda) + '.docx';
                        //ĐK  Contract115.SAVEASWORD(tempSaveDest);
                        FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                        IF Attachment.GET("Attachment No.") THEN
                            Attachment.TESTFIELD("Read Only", FALSE);

                        IF "Attachment No." <> 0 THEN BEGIN
                            IF NOT CONFIRM(Text004, FALSE) THEN
                                EXIT;
                            RemoveAttachment(FALSE);
                            "Attachment No." := 0;
                            MODIFY(FALSE);
                            COMMIT;
                        END;

                        NewAttachNo := AttachmentManagement.InsertAttachment("Attachment No.");
                        IF NewAttachNo <> 0 THEN BEGIN
                            "Attachment No." := NewAttachNo;

                            COMMIT;
                        END;


                    END;
                    ImportAttachment;
                END;




                IF CerAndSol."NAV Agreement Code" = 5061 THEN BEGIN


                    CRL.SETFILTER("Report ID", '%1', CerAndSol."NAV Agreement Code");
                    IF CRL.FINDLAST THEN BEGIN
                        ReportLayoutSelection.SetTempLayoutSelected(FORMAT(CRL."REPORT ID"));
                        Cert.SETFILTER("Employee No.", '%1', Rec."Employee No.");

                        BrojPotvrda := 0;
                        Cert1.RESET;
                        Cert1.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                        Cert1.SETFILTER(Group, '%1', Rec.Group);
                        IF Cert1.FIND('-') THEN BEGIN
                            BrojPotvrda := Cert1.COUNT;
                        END;
                        //ĐK Contract5061.SetParam("Employee No.",Rec."Agreement Code",0,Rec."Date Of certifications");
                        hr.GET;

                        tempSaveDest := hr."File Path" + "Employee No." + '-' + FORMAT(BrojPotvrda) + '.docx';
                        //ĐK  Contract5061.SAVEASWORD(tempSaveDest);
                        FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                        IF Attachment.GET("Attachment No.") THEN
                            Attachment.TESTFIELD("Read Only", FALSE);

                        IF "Attachment No." <> 0 THEN BEGIN
                            IF NOT CONFIRM(Text004, FALSE) THEN
                                EXIT;
                            RemoveAttachment(FALSE);
                            "Attachment No." := 0;
                            MODIFY(FALSE);
                            COMMIT;
                        END;

                        NewAttachNo := AttachmentManagement.InsertAttachment("Attachment No.");
                        IF NewAttachNo <> 0 THEN BEGIN
                            "Attachment No." := NewAttachNo;

                            COMMIT;
                        END;


                    END;
                    ImportAttachment;
                END;


                IF CerAndSol."NAV Agreement Code" = 5062 THEN BEGIN


                    CRL.SETFILTER("Report ID", '%1', CerAndSol."NAV Agreement Code");
                    IF CRL.FINDLAST THEN BEGIN
                        ReportLayoutSelection.SetTempLayoutSelected(FORMAT(CRL."REPORT ID"));
                        Cert.SETFILTER("Employee No.", '%1', Rec."Employee No.");

                        BrojPotvrda := 0;
                        Cert1.RESET;
                        Cert1.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                        Cert1.SETFILTER(Group, '%1', Rec.Group);
                        IF Cert1.FIND('-') THEN BEGIN
                            BrojPotvrda := Cert1.COUNT;
                        END;
                        //ĐK   Contract5062.SetParam("Employee No.",Rec."Agreement Code",0,Rec."Date Of certifications");
                        hr.GET;

                        tempSaveDest := hr."File Path" + "Employee No." + '-' + FORMAT(BrojPotvrda) + '.docx';
                        //ĐK Contract5062.SAVEASWORD(tempSaveDest);
                        FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                        IF Attachment.GET("Attachment No.") THEN
                            Attachment.TESTFIELD("Read Only", FALSE);

                        IF "Attachment No." <> 0 THEN BEGIN
                            IF NOT CONFIRM(Text004, FALSE) THEN
                                EXIT;
                            RemoveAttachment(FALSE);
                            "Attachment No." := 0;
                            MODIFY(FALSE);
                            COMMIT;
                        END;

                        NewAttachNo := AttachmentManagement.InsertAttachment("Attachment No.");
                        IF NewAttachNo <> 0 THEN BEGIN
                            "Attachment No." := NewAttachNo;

                            COMMIT;
                        END;


                    END;
                    ImportAttachment;
                END;


                IF CerAndSol."NAV Agreement Code" = 5063 THEN BEGIN


                    CRL.SETFILTER("Report ID", '%1', CerAndSol."NAV Agreement Code");
                    IF CRL.FINDLAST THEN BEGIN
                        ReportLayoutSelection.SetTempLayoutSelected(FORMAT(CRL."REPORT ID"));
                        Cert.SETFILTER("Employee No.", '%1', Rec."Employee No.");

                        BrojPotvrda := 0;
                        Cert1.RESET;
                        Cert1.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                        Cert1.SETFILTER(Group, '%1', Rec.Group);
                        IF Cert1.FIND('-') THEN BEGIN
                            BrojPotvrda := Cert1.COUNT;
                        END;
                        //ĐK    Contract5063.SetParam("Employee No.",Rec."Agreement Code",0,Rec."Date Of certifications");
                        hr.GET;

                        tempSaveDest := hr."File Path" + "Employee No." + '-' + FORMAT(BrojPotvrda) + '.docx';
                        //ĐK  Contract5063.SAVEASWORD(tempSaveDest);
                        FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                        IF Attachment.GET("Attachment No.") THEN
                            Attachment.TESTFIELD("Read Only", FALSE);

                        IF "Attachment No." <> 0 THEN BEGIN
                            IF NOT CONFIRM(Text004, FALSE) THEN
                                EXIT;
                            RemoveAttachment(FALSE);
                            "Attachment No." := 0;
                            MODIFY(FALSE);
                            COMMIT;
                        END;

                        NewAttachNo := AttachmentManagement.InsertAttachment("Attachment No.");
                        IF NewAttachNo <> 0 THEN BEGIN
                            "Attachment No." := NewAttachNo;

                            COMMIT;
                        END;


                    END;
                    ImportAttachment;
                END;


                IF CerAndSol."NAV Agreement Code" = 129 THEN BEGIN


                    CRL.SETFILTER("Report ID", '%1', CerAndSol."NAV Agreement Code");
                    IF CRL.FINDLAST THEN BEGIN
                        ReportLayoutSelection.SetTempLayoutSelected(FORMAT(CRL."REPORT ID"));
                        Cert.SETFILTER("Employee No.", '%1', Rec."Employee No.");

                        BrojPotvrda := 0;
                        Cert1.RESET;
                        Cert1.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                        IF Cert1.FIND('-') THEN BEGIN
                            BrojPotvrda := Cert1.COUNT;
                        END;
                        //ĐK     Contract129.SetParam("Employee No.",Rec."Agreement Code",0,Rec."Date Of certifications");
                        hr.GET;

                        tempSaveDest := hr."File Path" + "Employee No." + '-' + FORMAT(BrojPotvrda) + '.docx';
                        //ĐK  Contract129.SAVEASWORD(tempSaveDest);
                        FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                        IF Attachment.GET("Attachment No.") THEN
                            Attachment.TESTFIELD("Read Only", FALSE);

                        IF "Attachment No." <> 0 THEN BEGIN
                            IF NOT CONFIRM(Text004, FALSE) THEN
                                EXIT;
                            RemoveAttachment(FALSE);
                            "Attachment No." := 0;
                            MODIFY(FALSE);
                            COMMIT;
                        END;

                        NewAttachNo := AttachmentManagement.InsertAttachment("Attachment No.");
                        IF NewAttachNo <> 0 THEN BEGIN
                            "Attachment No." := NewAttachNo;

                            COMMIT;
                        END;


                    END;
                    ImportAttachment;
                END;



                IF CerAndSol."NAV Agreement Code" = 187 THEN BEGIN


                    CRL.SETFILTER("Report ID", '%1', CerAndSol."NAV Agreement Code");
                    IF CRL.FINDLAST THEN BEGIN
                        ReportLayoutSelection.SetTempLayoutSelected(FORMAT(CRL."REPORT ID"));
                        Cert.SETFILTER("Employee No.", '%1', Rec."Employee No.");

                        BrojPotvrda := 0;
                        Cert1.RESET;
                        Cert1.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                        IF Cert1.FIND('-') THEN BEGIN
                            BrojPotvrda := Cert1.COUNT;
                        END;
                        //ĐK       Contract187.SetParam("Employee No.",Rec."Agreement Code",0,Rec."Date Of certifications");
                        hr.GET;

                        tempSaveDest := hr."File Path" + "Employee No." + '-' + FORMAT(BrojPotvrda) + '.docx';
                        //ĐK     Contract187.SAVEASWORD(tempSaveDest);
                        FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                        IF Attachment.GET("Attachment No.") THEN
                            Attachment.TESTFIELD("Read Only", FALSE);

                        IF "Attachment No." <> 0 THEN BEGIN
                            IF NOT CONFIRM(Text004, FALSE) THEN
                                EXIT;
                            RemoveAttachment(FALSE);
                            "Attachment No." := 0;
                            MODIFY(FALSE);
                            COMMIT;
                        END;

                        NewAttachNo := AttachmentManagement.InsertAttachment("Attachment No.");
                        IF NewAttachNo <> 0 THEN BEGIN
                            "Attachment No." := NewAttachNo;

                            COMMIT;
                        END;


                    END;
                    ImportAttachment;
                END;



                IF CerAndSol."NAV Agreement Code" = 188 THEN BEGIN


                    CRL.SETFILTER("Report ID", '%1', CerAndSol."NAV Agreement Code");
                    IF CRL.FINDLAST THEN BEGIN
                        ReportLayoutSelection.SetTempLayoutSelected(FORMAT(CRL."REPORT ID"));
                        Cert.SETFILTER("Employee No.", '%1', Rec."Employee No.");

                        BrojPotvrda := 0;
                        Cert1.RESET;
                        Cert1.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                        IF Cert1.FIND('-') THEN BEGIN
                            BrojPotvrda := Cert1.COUNT;
                        END;
                        //ĐK   Contract188.SetParam("Employee No.",Rec."Agreement Code",0,Rec."Date Of certifications");
                        hr.GET;

                        tempSaveDest := hr."File Path" + "Employee No." + '-' + FORMAT(BrojPotvrda) + '.docx';
                        //ĐK   Contract188.SAVEASWORD(tempSaveDest);
                        FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                        IF Attachment.GET("Attachment No.") THEN
                            Attachment.TESTFIELD("Read Only", FALSE);

                        IF "Attachment No." <> 0 THEN BEGIN
                            IF NOT CONFIRM(Text004, FALSE) THEN
                                EXIT;
                            RemoveAttachment(FALSE);
                            "Attachment No." := 0;
                            MODIFY(FALSE);
                            COMMIT;
                        END;

                        NewAttachNo := AttachmentManagement.InsertAttachment("Attachment No.");
                        IF NewAttachNo <> 0 THEN BEGIN
                            "Attachment No." := NewAttachNo;

                            COMMIT;
                        END;


                    END;
                    ImportAttachment;
                END;


                IF CerAndSol."NAV Agreement Code" = 189 THEN BEGIN


                    CRL.SETFILTER("Report ID", '%1', CerAndSol."NAV Agreement Code");
                    IF CRL.FINDLAST THEN BEGIN
                        ReportLayoutSelection.SetTempLayoutSelected(FORMAT(CRL."REPORT ID"));
                        Cert.SETFILTER("Employee No.", '%1', Rec."Employee No.");

                        BrojPotvrda := 0;
                        Cert1.RESET;
                        Cert1.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                        IF Cert1.FIND('-') THEN BEGIN
                            BrojPotvrda := Cert1.COUNT;
                        END;
                        //ĐK        Contract189.SetParam("Employee No.",Rec."Agreement Code",0,Rec."Date Of certifications");
                        hr.GET;

                        tempSaveDest := hr."File Path" + "Employee No." + '-' + FORMAT(BrojPotvrda) + '.docx';
                        //ĐK       Contract189.SAVEASWORD(tempSaveDest);
                        FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                        IF Attachment.GET("Attachment No.") THEN
                            Attachment.TESTFIELD("Read Only", FALSE);

                        IF "Attachment No." <> 0 THEN BEGIN
                            IF NOT CONFIRM(Text004, FALSE) THEN
                                EXIT;
                            RemoveAttachment(FALSE);
                            "Attachment No." := 0;
                            MODIFY(FALSE);
                            COMMIT;
                        END;

                        NewAttachNo := AttachmentManagement.InsertAttachment("Attachment No.");
                        IF NewAttachNo <> 0 THEN BEGIN
                            "Attachment No." := NewAttachNo;

                            COMMIT;
                        END;


                    END;
                    ImportAttachment;
                END;

                IF CerAndSol."NAV Agreement Code" = 190 THEN BEGIN


                    CRL.SETFILTER("Report ID", '%1', CerAndSol."NAV Agreement Code");
                    IF CRL.FINDLAST THEN BEGIN
                        ReportLayoutSelection.SetTempLayoutSelected(FORMAT(CRL."REPORT ID"));
                        Cert.SETFILTER("Employee No.", '%1', Rec."Employee No.");

                        BrojPotvrda := 0;
                        Cert1.RESET;
                        Cert1.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                        IF Cert1.FIND('-') THEN BEGIN
                            BrojPotvrda := Cert1.COUNT;
                        END;
                        //ĐK       Contract190.SetParam("Employee No.",Rec."Agreement Code",0,Rec."Date Of certifications");
                        hr.GET;

                        tempSaveDest := hr."File Path" + "Employee No." + '-' + FORMAT(BrojPotvrda) + '.docx';
                        //ĐK     Contract190.SAVEASWORD(tempSaveDest);
                        FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                        IF Attachment.GET("Attachment No.") THEN
                            Attachment.TESTFIELD("Read Only", FALSE);

                        IF "Attachment No." <> 0 THEN BEGIN
                            IF NOT CONFIRM(Text004, FALSE) THEN
                                EXIT;
                            RemoveAttachment(FALSE);
                            "Attachment No." := 0;
                            MODIFY(FALSE);
                            COMMIT;
                        END;

                        NewAttachNo := AttachmentManagement.InsertAttachment("Attachment No.");
                        IF NewAttachNo <> 0 THEN BEGIN
                            "Attachment No." := NewAttachNo;

                            COMMIT;
                        END;


                    END;
                    ImportAttachment;
                END;
                IF CerAndSol."NAV Agreement Code" = 191 THEN BEGIN


                    CRL.SETFILTER("Report ID", '%1', CerAndSol."NAV Agreement Code");
                    IF CRL.FINDLAST THEN BEGIN
                        ReportLayoutSelection.SetTempLayoutSelected(FORMAT(CRL."REPORT ID"));
                        Cert.SETFILTER("Employee No.", '%1', Rec."Employee No.");

                        BrojPotvrda := 0;
                        Cert1.RESET;
                        Cert1.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                        IF Cert1.FIND('-') THEN BEGIN
                            BrojPotvrda := Cert1.COUNT;
                        END;
                        //ĐK     Contract191.SetParam("Employee No.",Rec."Agreement Code",0,Rec."Date Of certifications");
                        hr.GET;

                        tempSaveDest := hr."File Path" + "Employee No." + '-' + FORMAT(BrojPotvrda) + '.docx';
                        //ĐK   Contract191.SAVEASWORD(tempSaveDest);
                        FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                        IF Attachment.GET("Attachment No.") THEN
                            Attachment.TESTFIELD("Read Only", FALSE);

                        IF "Attachment No." <> 0 THEN BEGIN
                            IF NOT CONFIRM(Text004, FALSE) THEN
                                EXIT;
                            RemoveAttachment(FALSE);
                            "Attachment No." := 0;
                            MODIFY(FALSE);
                            COMMIT;
                        END;

                        NewAttachNo := AttachmentManagement.InsertAttachment("Attachment No.");
                        IF NewAttachNo <> 0 THEN BEGIN
                            "Attachment No." := NewAttachNo;

                            COMMIT;
                        END;


                    END;
                    ImportAttachment;
                END;
                IF CerAndSol."NAV Agreement Code" = 192 THEN BEGIN


                    CRL.SETFILTER("Report ID", '%1', CerAndSol."NAV Agreement Code");
                    IF CRL.FINDLAST THEN BEGIN
                        ReportLayoutSelection.SetTempLayoutSelected(FORMAT(CRL."REPORT ID"));
                        Cert.SETFILTER("Employee No.", '%1', Rec."Employee No.");

                        BrojPotvrda := 0;
                        Cert1.RESET;
                        Cert1.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                        IF Cert1.FIND('-') THEN BEGIN
                            BrojPotvrda := Cert1.COUNT;
                        END;
                        //ĐK      Contract192.SetParam("Employee No.",Rec."Agreement Code",0,Rec."Date Of certifications");
                        hr.GET;

                        tempSaveDest := hr."File Path" + "Employee No." + '-' + FORMAT(BrojPotvrda) + '.docx';
                        //ĐK    Contract192.SAVEASWORD(tempSaveDest);
                        FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                        IF Attachment.GET("Attachment No.") THEN
                            Attachment.TESTFIELD("Read Only", FALSE);

                        IF "Attachment No." <> 0 THEN BEGIN
                            IF NOT CONFIRM(Text004, FALSE) THEN
                                EXIT;
                            RemoveAttachment(FALSE);
                            "Attachment No." := 0;
                            MODIFY(FALSE);
                            COMMIT;
                        END;

                        NewAttachNo := AttachmentManagement.InsertAttachment("Attachment No.");
                        IF NewAttachNo <> 0 THEN BEGIN
                            "Attachment No." := NewAttachNo;

                            COMMIT;
                        END;


                    END;
                    ImportAttachment;
                END;

                IF CerAndSol."NAV Agreement Code" = 193 THEN BEGIN


                    CRL.SETFILTER("Report ID", '%1', CerAndSol."NAV Agreement Code");
                    IF CRL.FINDLAST THEN BEGIN
                        ReportLayoutSelection.SetTempLayoutSelected(FORMAT(CRL."REPORT ID"));
                        Cert.SETFILTER("Employee No.", '%1', Rec."Employee No.");

                        BrojPotvrda := 0;
                        Cert1.RESET;
                        Cert1.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                        IF Cert1.FIND('-') THEN BEGIN
                            BrojPotvrda := Cert1.COUNT;
                        END;
                        //ĐK Contract193.SetParam("Employee No.",Rec."Agreement Code",0,Rec."Date Of certifications");
                        hr.GET;

                        tempSaveDest := hr."File Path" + "Employee No." + '-' + FORMAT(BrojPotvrda) + '.docx';
                        //ĐK  Contract193.SAVEASWORD(tempSaveDest);
                        FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                        IF Attachment.GET("Attachment No.") THEN
                            Attachment.TESTFIELD("Read Only", FALSE);

                        IF "Attachment No." <> 0 THEN BEGIN
                            IF NOT CONFIRM(Text004, FALSE) THEN
                                EXIT;
                            RemoveAttachment(FALSE);
                            "Attachment No." := 0;
                            MODIFY(FALSE);
                            COMMIT;
                        END;

                        NewAttachNo := AttachmentManagement.InsertAttachment("Attachment No.");
                        IF NewAttachNo <> 0 THEN BEGIN
                            "Attachment No." := NewAttachNo;

                            COMMIT;
                        END;


                    END;
                    ImportAttachment;
                END;

                IF CerAndSol."NAV Agreement Code" = 215 THEN BEGIN


                    CRL.SETFILTER("Report ID", '%1', CerAndSol."NAV Agreement Code");
                    IF CRL.FINDLAST THEN BEGIN
                        ReportLayoutSelection.SetTempLayoutSelected(FORMAT(CRL."REPORT ID"));
                        Cert.SETFILTER("Employee No.", '%1', Rec."Employee No.");

                        BrojPotvrda := 0;
                        Cert1.RESET;
                        Cert1.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                        IF Cert1.FIND('-') THEN BEGIN
                            BrojPotvrda := Cert1.COUNT;
                        END;
                        //ĐK Contract215.SetParam("Employee No.",Rec."Agreement Code",0,Rec."Date Of certifications");
                        hr.GET;

                        tempSaveDest := hr."File Path" + "Employee No." + '-' + FORMAT(BrojPotvrda) + '.docx';
                        //ĐK Contract215.SAVEASWORD(tempSaveDest);
                        FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                        IF Attachment.GET("Attachment No.") THEN
                            Attachment.TESTFIELD("Read Only", FALSE);

                        IF "Attachment No." <> 0 THEN BEGIN
                            IF NOT CONFIRM(Text004, FALSE) THEN
                                EXIT;
                            RemoveAttachment(FALSE);
                            "Attachment No." := 0;
                            MODIFY(FALSE);
                            COMMIT;
                        END;

                        NewAttachNo := AttachmentManagement.InsertAttachment("Attachment No.");
                        IF NewAttachNo <> 0 THEN BEGIN
                            "Attachment No." := NewAttachNo;

                            COMMIT;
                        END;


                    END;
                    ImportAttachment;
                END;

                IF CerAndSol."NAV Agreement Code" = 216 THEN BEGIN


                    CRL.SETFILTER("Report ID", '%1', CerAndSol."NAV Agreement Code");
                    IF CRL.FINDLAST THEN BEGIN
                        ReportLayoutSelection.SetTempLayoutSelected(FORMAT(CRL."REPORT ID"));
                        Cert.SETFILTER("Employee No.", '%1', Rec."Employee No.");

                        BrojPotvrda := 0;
                        Cert1.RESET;
                        Cert1.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                        IF Cert1.FIND('-') THEN BEGIN
                            BrojPotvrda := Cert1.COUNT;
                        END;
                        //ĐK    Contract216.SetParam("Employee No.",Rec."Agreement Code",0,Rec."Date Of certifications");
                        hr.GET;

                        tempSaveDest := hr."File Path" + "Employee No." + '-' + FORMAT(BrojPotvrda) + '.docx';
                        //ĐK  Contract216.SAVEASWORD(tempSaveDest);
                        FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                        IF Attachment.GET("Attachment No.") THEN
                            Attachment.TESTFIELD("Read Only", FALSE);

                        IF "Attachment No." <> 0 THEN BEGIN
                            IF NOT CONFIRM(Text004, FALSE) THEN
                                EXIT;
                            RemoveAttachment(FALSE);
                            "Attachment No." := 0;
                            MODIFY(FALSE);
                            COMMIT;
                        END;

                        NewAttachNo := AttachmentManagement.InsertAttachment("Attachment No.");
                        IF NewAttachNo <> 0 THEN BEGIN
                            "Attachment No." := NewAttachNo;

                            COMMIT;
                        END;


                    END;
                    ImportAttachment;
                END;

                IF CerAndSol."NAV Agreement Code" = 291 THEN BEGIN


                    CRL.SETFILTER("Report ID", '%1', CerAndSol."NAV Agreement Code");
                    IF CRL.FINDLAST THEN BEGIN
                        ReportLayoutSelection.SetTempLayoutSelected(FORMAT(CRL."REPORT ID"));
                        Cert.SETFILTER("Employee No.", '%1', Rec."Employee No.");

                        BrojPotvrda := 0;
                        Cert1.RESET;
                        Cert1.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                        IF Cert1.FIND('-') THEN BEGIN
                            BrojPotvrda := Cert1.COUNT;
                        END;
                        //ĐK    Contract291.SetParam("Employee No.",Rec."Agreement Code",0,Rec."Date Of certifications");
                        hr.GET;

                        tempSaveDest := hr."File Path" + "Employee No." + '-' + FORMAT(BrojPotvrda) + '.docx';
                        //ĐK   Contract291.SAVEASWORD(tempSaveDest);
                        FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                        IF Attachment.GET("Attachment No.") THEN
                            Attachment.TESTFIELD("Read Only", FALSE);

                        IF "Attachment No." <> 0 THEN BEGIN
                            IF NOT CONFIRM(Text004, FALSE) THEN
                                EXIT;
                            RemoveAttachment(FALSE);
                            "Attachment No." := 0;
                            MODIFY(FALSE);
                            COMMIT;
                        END;

                        NewAttachNo := AttachmentManagement.InsertAttachment("Attachment No.");
                        IF NewAttachNo <> 0 THEN BEGIN
                            "Attachment No." := NewAttachNo;

                            COMMIT;
                        END;


                    END;
                    ImportAttachment;
                END;

                IF CerAndSol."NAV Agreement Code" = 292 THEN BEGIN


                    CRL.SETFILTER("Report ID", '%1', CerAndSol."NAV Agreement Code");
                    IF CRL.FINDLAST THEN BEGIN
                        ReportLayoutSelection.SetTempLayoutSelected(FORMAT(CRL."REPORT ID"));
                        Cert.SETFILTER("Employee No.", '%1', Rec."Employee No.");

                        BrojPotvrda := 0;
                        Cert1.RESET;
                        Cert1.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                        IF Cert1.FIND('-') THEN BEGIN
                            BrojPotvrda := Cert1.COUNT;
                        END;
                        //ĐK     Contract292.SetParam("Employee No.",Rec."Agreement Code",0,Rec."Date Of certifications");
                        hr.GET;

                        tempSaveDest := hr."File Path" + "Employee No." + '-' + FORMAT(BrojPotvrda) + '.docx';
                        //ĐK   Contract292.SAVEASWORD(tempSaveDest);
                        FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                        IF Attachment.GET("Attachment No.") THEN
                            Attachment.TESTFIELD("Read Only", FALSE);

                        IF "Attachment No." <> 0 THEN BEGIN
                            IF NOT CONFIRM(Text004, FALSE) THEN
                                EXIT;
                            RemoveAttachment(FALSE);
                            "Attachment No." := 0;
                            MODIFY(FALSE);
                            COMMIT;
                        END;

                        NewAttachNo := AttachmentManagement.InsertAttachment("Attachment No.");
                        IF NewAttachNo <> 0 THEN BEGIN
                            "Attachment No." := NewAttachNo;

                            COMMIT;
                        END;


                    END;
                    ImportAttachment;
                END;

                IF CerAndSol."NAV Agreement Code" = 296 THEN BEGIN


                    CRL.SETFILTER("Report ID", '%1', CerAndSol."NAV Agreement Code");
                    IF CRL.FINDLAST THEN BEGIN
                        ReportLayoutSelection.SetTempLayoutSelected(FORMAT(CRL."REPORT ID"));
                        Cert.SETFILTER("Employee No.", '%1', Rec."Employee No.");

                        BrojPotvrda := 0;
                        Cert1.RESET;
                        Cert1.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                        IF Cert1.FIND('-') THEN BEGIN
                            BrojPotvrda := Cert1.COUNT;
                        END;
                        //ĐK Contract296.SetParam("Employee No.",Rec."Agreement Code",0,Rec."Date Of certifications");
                        hr.GET;

                        tempSaveDest := hr."File Path" + "Employee No." + '-' + FORMAT(BrojPotvrda) + '.docx';
                        //ĐK   Contract296.SAVEASWORD(tempSaveDest);
                        FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                        IF Attachment.GET("Attachment No.") THEN
                            Attachment.TESTFIELD("Read Only", FALSE);

                        IF "Attachment No." <> 0 THEN BEGIN
                            IF NOT CONFIRM(Text004, FALSE) THEN
                                EXIT;
                            RemoveAttachment(FALSE);
                            "Attachment No." := 0;
                            MODIFY(FALSE);
                            COMMIT;
                        END;

                        NewAttachNo := AttachmentManagement.InsertAttachment("Attachment No.");
                        IF NewAttachNo <> 0 THEN BEGIN
                            "Attachment No." := NewAttachNo;

                            COMMIT;
                        END;


                    END;
                    ImportAttachment;
                END;

                IF CerAndSol."NAV Agreement Code" = 297 THEN BEGIN


                    CRL.SETFILTER("Report ID", '%1', CerAndSol."NAV Agreement Code");
                    IF CRL.FINDLAST THEN BEGIN
                        ReportLayoutSelection.SetTempLayoutSelected(FORMAT(CRL."REPORT ID"));
                        Cert.SETFILTER("Employee No.", '%1', Rec."Employee No.");

                        BrojPotvrda := 0;
                        Cert1.RESET;
                        Cert1.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                        IF Cert1.FIND('-') THEN BEGIN
                            BrojPotvrda := Cert1.COUNT;
                        END;
                        //ĐK     Contract297.SetParam("Employee No.",Rec."Agreement Code",0,Rec."Date Of certifications");
                        hr.GET;

                        tempSaveDest := hr."File Path" + "Employee No." + '-' + FORMAT(BrojPotvrda) + '.docx';
                        //ĐK   Contract297.SAVEASWORD(tempSaveDest);
                        FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                        IF Attachment.GET("Attachment No.") THEN
                            Attachment.TESTFIELD("Read Only", FALSE);

                        IF "Attachment No." <> 0 THEN BEGIN
                            IF NOT CONFIRM(Text004, FALSE) THEN
                                EXIT;
                            RemoveAttachment(FALSE);
                            "Attachment No." := 0;
                            MODIFY(FALSE);
                            COMMIT;
                        END;

                        NewAttachNo := AttachmentManagement.InsertAttachment("Attachment No.");
                        IF NewAttachNo <> 0 THEN BEGIN
                            "Attachment No." := NewAttachNo;

                            COMMIT;
                        END;


                    END;
                    ImportAttachment;
                END;


                IF CerAndSol."NAV Agreement Code" = 298 THEN BEGIN


                    CRL.SETFILTER("Report ID", '%1', CerAndSol."NAV Agreement Code");
                    IF CRL.FINDLAST THEN BEGIN
                        ReportLayoutSelection.SetTempLayoutSelected(FORMAT(CRL."REPORT ID"));
                        Cert.SETFILTER("Employee No.", '%1', Rec."Employee No.");

                        BrojPotvrda := 0;
                        Cert1.RESET;
                        Cert1.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                        IF Cert1.FIND('-') THEN BEGIN
                            BrojPotvrda := Cert1.COUNT;
                        END;
                        //ĐK      Contract298.SetParam("Employee No.",Rec."Agreement Code",0,Rec."Date Of certifications");
                        hr.GET;

                        tempSaveDest := hr."File Path" + "Employee No." + '-' + FORMAT(BrojPotvrda) + '.docx';
                        //ĐK    Contract298.SAVEASWORD(tempSaveDest);
                        FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                        IF Attachment.GET("Attachment No.") THEN
                            Attachment.TESTFIELD("Read Only", FALSE);

                        IF "Attachment No." <> 0 THEN BEGIN
                            IF NOT CONFIRM(Text004, FALSE) THEN
                                EXIT;
                            RemoveAttachment(FALSE);
                            "Attachment No." := 0;
                            MODIFY(FALSE);
                            COMMIT;
                        END;

                        NewAttachNo := AttachmentManagement.InsertAttachment("Attachment No.");
                        IF NewAttachNo <> 0 THEN BEGIN
                            "Attachment No." := NewAttachNo;

                            COMMIT;
                        END;


                    END;
                    ImportAttachment;
                END;

                IF CerAndSol."NAV Agreement Code" = 319 THEN BEGIN


                    CRL.SETFILTER("Report ID", '%1', CerAndSol."NAV Agreement Code");
                    IF CRL.FINDLAST THEN BEGIN
                        ReportLayoutSelection.SetTempLayoutSelected(FORMAT(CRL."REPORT ID"));
                        Cert.SETFILTER("Employee No.", '%1', Rec."Employee No.");

                        BrojPotvrda := 0;
                        Cert1.RESET;
                        Cert1.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                        IF Cert1.FIND('-') THEN BEGIN
                            BrojPotvrda := Cert1.COUNT;
                        END;
                        //ĐK      Contract319.SetParam("Employee No.",Rec."Agreement Code",0,Rec."Date Of certifications");
                        hr.GET;

                        tempSaveDest := hr."File Path" + "Employee No." + '-' + FORMAT(BrojPotvrda) + '.docx';
                        //ĐK  Contract319.SAVEASWORD(tempSaveDest);
                        FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                        IF Attachment.GET("Attachment No.") THEN
                            Attachment.TESTFIELD("Read Only", FALSE);

                        IF "Attachment No." <> 0 THEN BEGIN
                            IF NOT CONFIRM(Text004, FALSE) THEN
                                EXIT;
                            RemoveAttachment(FALSE);
                            "Attachment No." := 0;
                            MODIFY(FALSE);
                            COMMIT;
                        END;

                        NewAttachNo := AttachmentManagement.InsertAttachment("Attachment No.");
                        IF NewAttachNo <> 0 THEN BEGIN
                            "Attachment No." := NewAttachNo;

                            COMMIT;
                        END;


                    END;
                    ImportAttachment;
                END;

                IF CerAndSol."NAV Agreement Code" = 322 THEN BEGIN


                    CRL.SETFILTER("Report ID", '%1', CerAndSol."NAV Agreement Code");
                    IF CRL.FINDLAST THEN BEGIN
                        ReportLayoutSelection.SetTempLayoutSelected(FORMAT(CRL."REPORT ID"));
                        Cert.SETFILTER("Employee No.", '%1', Rec."Employee No.");

                        BrojPotvrda := 0;
                        Cert1.RESET;
                        Cert1.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                        IF Cert1.FIND('-') THEN BEGIN
                            BrojPotvrda := Cert1.COUNT;
                        END;
                        //ĐK     Contract322.SetParam("Employee No.",Rec."Agreement Code",0,Rec."Date Of certifications");
                        hr.GET;

                        tempSaveDest := hr."File Path" + "Employee No." + '-' + FORMAT(BrojPotvrda) + '.docx';
                        //ĐK    Contract322.SAVEASWORD(tempSaveDest);
                        FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                        IF Attachment.GET("Attachment No.") THEN
                            Attachment.TESTFIELD("Read Only", FALSE);

                        IF "Attachment No." <> 0 THEN BEGIN
                            IF NOT CONFIRM(Text004, FALSE) THEN
                                EXIT;
                            RemoveAttachment(FALSE);
                            "Attachment No." := 0;
                            MODIFY(FALSE);
                            COMMIT;
                        END;

                        NewAttachNo := AttachmentManagement.InsertAttachment("Attachment No.");
                        IF NewAttachNo <> 0 THEN BEGIN
                            "Attachment No." := NewAttachNo;

                            COMMIT;
                        END;


                    END;
                    ImportAttachment;
                END;

                IF CerAndSol."NAV Agreement Code" = 324 THEN BEGIN


                    CRL.SETFILTER("Report ID", '%1', CerAndSol."NAV Agreement Code");
                    IF CRL.FINDLAST THEN BEGIN
                        ReportLayoutSelection.SetTempLayoutSelected(FORMAT(CRL."REPORT ID"));
                        Cert.SETFILTER("Employee No.", '%1', Rec."Employee No.");

                        BrojPotvrda := 0;
                        Cert1.RESET;
                        Cert1.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                        IF Cert1.FIND('-') THEN BEGIN
                            BrojPotvrda := Cert1.COUNT;
                        END;
                        //ĐK       Contract324.SetParam("Employee No.",Rec."Agreement Code",0,Rec."Date Of certifications");
                        hr.GET;

                        tempSaveDest := hr."File Path" + "Employee No." + '-' + FORMAT(BrojPotvrda) + '.docx';
                        //ĐK     Contract324.SAVEASWORD(tempSaveDest);
                        FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                        IF Attachment.GET("Attachment No.") THEN
                            Attachment.TESTFIELD("Read Only", FALSE);

                        IF "Attachment No." <> 0 THEN BEGIN
                            IF NOT CONFIRM(Text004, FALSE) THEN
                                EXIT;
                            RemoveAttachment(FALSE);
                            "Attachment No." := 0;
                            MODIFY(FALSE);
                            COMMIT;
                        END;

                        NewAttachNo := AttachmentManagement.InsertAttachment("Attachment No.");
                        IF NewAttachNo <> 0 THEN BEGIN
                            "Attachment No." := NewAttachNo;

                            COMMIT;
                        END;


                    END;
                    ImportAttachment;
                END;

                IF CerAndSol."NAV Agreement Code" = 406 THEN BEGIN


                    CRL.SETFILTER("Report ID", '%1', CerAndSol."NAV Agreement Code");
                    IF CRL.FINDLAST THEN BEGIN
                        ReportLayoutSelection.SetTempLayoutSelected(FORMAT(CRL."REPORT ID"));
                        Cert.SETFILTER("Employee No.", '%1', Rec."Employee No.");

                        BrojPotvrda := 0;
                        Cert1.RESET;
                        Cert1.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                        IF Cert1.FIND('-') THEN BEGIN
                            BrojPotvrda := Cert1.COUNT;
                        END;
                        //ĐK       Contract406.SetParam("Employee No.",Rec."Agreement Code",0,Rec."Date Of certifications");
                        hr.GET;

                        tempSaveDest := hr."File Path" + "Employee No." + '-' + FORMAT(BrojPotvrda) + '.docx';
                        //ĐK      Contract406.SAVEASWORD(tempSaveDest);
                        FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                        IF Attachment.GET("Attachment No.") THEN
                            Attachment.TESTFIELD("Read Only", FALSE);

                        IF "Attachment No." <> 0 THEN BEGIN
                            IF NOT CONFIRM(Text004, FALSE) THEN
                                EXIT;
                            RemoveAttachment(FALSE);
                            "Attachment No." := 0;
                            MODIFY(FALSE);
                            COMMIT;
                        END;

                        NewAttachNo := AttachmentManagement.InsertAttachment("Attachment No.");
                        IF NewAttachNo <> 0 THEN BEGIN
                            "Attachment No." := NewAttachNo;

                            COMMIT;
                        END;


                    END;
                    ImportAttachment;
                END;

                IF CerAndSol."NAV Agreement Code" = 407 THEN BEGIN


                    CRL.SETFILTER("Report ID", '%1', CerAndSol."NAV Agreement Code");
                    IF CRL.FINDLAST THEN BEGIN
                        ReportLayoutSelection.SetTempLayoutSelected(FORMAT(CRL."REPORT ID"));
                        Cert.SETFILTER("Employee No.", '%1', Rec."Employee No.");

                        BrojPotvrda := 0;
                        Cert1.RESET;
                        Cert1.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                        IF Cert1.FIND('-') THEN BEGIN
                            BrojPotvrda := Cert1.COUNT;
                        END;
                        //ĐK        Contract407.SetParam("Employee No.",Rec."Agreement Code",0,Rec."Date Of certifications");
                        hr.GET;

                        tempSaveDest := hr."File Path" + "Employee No." + '-' + FORMAT(BrojPotvrda) + '.docx';
                        //ĐK     Contract407.SAVEASWORD(tempSaveDest);
                        FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                        IF Attachment.GET("Attachment No.") THEN
                            Attachment.TESTFIELD("Read Only", FALSE);

                        IF "Attachment No." <> 0 THEN BEGIN
                            IF NOT CONFIRM(Text004, FALSE) THEN
                                EXIT;
                            RemoveAttachment(FALSE);
                            "Attachment No." := 0;
                            MODIFY(FALSE);
                            COMMIT;
                        END;

                        NewAttachNo := AttachmentManagement.InsertAttachment("Attachment No.");
                        IF NewAttachNo <> 0 THEN BEGIN
                            "Attachment No." := NewAttachNo;

                            COMMIT;
                        END;


                    END;
                    ImportAttachment;
                END;

                IF CerAndSol."NAV Agreement Code" = 408 THEN BEGIN


                    CRL.SETFILTER("Report ID", '%1', CerAndSol."NAV Agreement Code");
                    IF CRL.FINDLAST THEN BEGIN
                        ReportLayoutSelection.SetTempLayoutSelected(FORMAT(CRL."REPORT ID"));
                        Cert.SETFILTER("Employee No.", '%1', Rec."Employee No.");

                        BrojPotvrda := 0;
                        Cert1.RESET;
                        Cert1.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                        IF Cert1.FIND('-') THEN BEGIN
                            BrojPotvrda := Cert1.COUNT;
                        END;
                        //ĐK            Contract408.SetParam("Employee No.",Rec."Agreement Code",0,Rec."Date Of certifications");
                        hr.GET;

                        tempSaveDest := hr."File Path" + "Employee No." + '-' + FORMAT(BrojPotvrda) + '.docx';
                        //ĐK           Contract408.SAVEASWORD(tempSaveDest);
                        FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                        IF Attachment.GET("Attachment No.") THEN
                            Attachment.TESTFIELD("Read Only", FALSE);

                        IF "Attachment No." <> 0 THEN BEGIN
                            IF NOT CONFIRM(Text004, FALSE) THEN
                                EXIT;
                            RemoveAttachment(FALSE);
                            "Attachment No." := 0;
                            MODIFY(FALSE);
                            COMMIT;
                        END;

                        NewAttachNo := AttachmentManagement.InsertAttachment("Attachment No.");
                        IF NewAttachNo <> 0 THEN BEGIN
                            "Attachment No." := NewAttachNo;

                            COMMIT;
                        END;


                    END;
                    ImportAttachment;
                END;
                IF CerAndSol."NAV Agreement Code" = 410 THEN BEGIN


                    CRL.SETFILTER("Report ID", '%1', CerAndSol."NAV Agreement Code");
                    IF CRL.FINDLAST THEN BEGIN
                        ReportLayoutSelection.SetTempLayoutSelected(FORMAT(CRL."REPORT ID"));
                        Cert.SETFILTER("Employee No.", '%1', Rec."Employee No.");

                        BrojPotvrda := 0;
                        Cert1.RESET;
                        Cert1.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                        IF Cert1.FIND('-') THEN BEGIN
                            BrojPotvrda := Cert1.COUNT;
                        END;
                        //ĐK               Contract410.SetParam("Employee No.",Rec."Agreement Code",0,Rec."Date Of certifications");
                        hr.GET;

                        tempSaveDest := hr."File Path" + "Employee No." + '-' + FORMAT(BrojPotvrda) + '.docx';
                        //ĐK         Contract410.SAVEASWORD(tempSaveDest);
                        FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                        IF Attachment.GET("Attachment No.") THEN
                            Attachment.TESTFIELD("Read Only", FALSE);

                        IF "Attachment No." <> 0 THEN BEGIN
                            IF NOT CONFIRM(Text004, FALSE) THEN
                                EXIT;
                            RemoveAttachment(FALSE);
                            "Attachment No." := 0;
                            MODIFY(FALSE);
                            COMMIT;
                        END;

                        NewAttachNo := AttachmentManagement.InsertAttachment("Attachment No.");
                        IF NewAttachNo <> 0 THEN BEGIN
                            "Attachment No." := NewAttachNo;

                            COMMIT;
                        END;


                    END;
                    ImportAttachment;
                END;

                IF CerAndSol."NAV Agreement Code" = 412 THEN BEGIN


                    CRL.SETFILTER("Report ID", '%1', CerAndSol."NAV Agreement Code");
                    IF CRL.FINDLAST THEN BEGIN
                        ReportLayoutSelection.SetTempLayoutSelected(FORMAT(CRL."REPORT ID"));
                        Cert.SETFILTER("Employee No.", '%1', Rec."Employee No.");

                        BrojPotvrda := 0;
                        Cert1.RESET;
                        Cert1.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                        IF Cert1.FIND('-') THEN BEGIN
                            BrojPotvrda := Cert1.COUNT;
                        END;
                        //ĐK           Contract412.SetParam("Employee No.",Rec."Agreement Code",0,Rec."Date Of certifications");
                        hr.GET;

                        tempSaveDest := hr."File Path" + "Employee No." + '-' + FORMAT(BrojPotvrda) + '.docx';
                        //ĐK       Contract412.SAVEASWORD(tempSaveDest);
                        FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                        IF Attachment.GET("Attachment No.") THEN
                            Attachment.TESTFIELD("Read Only", FALSE);

                        IF "Attachment No." <> 0 THEN BEGIN
                            IF NOT CONFIRM(Text004, FALSE) THEN
                                EXIT;
                            RemoveAttachment(FALSE);
                            "Attachment No." := 0;
                            MODIFY(FALSE);
                            COMMIT;
                        END;

                        NewAttachNo := AttachmentManagement.InsertAttachment("Attachment No.");
                        IF NewAttachNo <> 0 THEN BEGIN
                            "Attachment No." := NewAttachNo;

                            COMMIT;
                        END;


                    END;
                    ImportAttachment;
                END;

                IF CerAndSol."NAV Agreement Code" = 415 THEN BEGIN


                    CRL.SETFILTER("Report ID", '%1', CerAndSol."NAV Agreement Code");
                    IF CRL.FINDLAST THEN BEGIN
                        ReportLayoutSelection.SetTempLayoutSelected(FORMAT(CRL."REPORT ID"));
                        Cert.SETFILTER("Employee No.", '%1', Rec."Employee No.");

                        BrojPotvrda := 0;
                        Cert1.RESET;
                        Cert1.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                        IF Cert1.FIND('-') THEN BEGIN
                            BrojPotvrda := Cert1.COUNT;
                        END;
                        //ĐK           Contract415.SetParam("Employee No.",Rec."Agreement Code",0,Rec."Date Of certifications");
                        hr.GET;

                        tempSaveDest := hr."File Path" + "Employee No." + '-' + FORMAT(BrojPotvrda) + '.docx';
                        //ĐK       Contract415.SAVEASWORD(tempSaveDest);
                        FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                        IF Attachment.GET("Attachment No.") THEN
                            Attachment.TESTFIELD("Read Only", FALSE);

                        IF "Attachment No." <> 0 THEN BEGIN
                            IF NOT CONFIRM(Text004, FALSE) THEN
                                EXIT;
                            RemoveAttachment(FALSE);
                            "Attachment No." := 0;
                            MODIFY(FALSE);
                            COMMIT;
                        END;

                        NewAttachNo := AttachmentManagement.InsertAttachment("Attachment No.");
                        IF NewAttachNo <> 0 THEN BEGIN
                            "Attachment No." := NewAttachNo;

                            COMMIT;
                        END;


                    END;
                    ImportAttachment;
                END;

                IF CerAndSol."NAV Agreement Code" = 416 THEN BEGIN


                    CRL.SETFILTER("Report ID", '%1', CerAndSol."NAV Agreement Code");
                    IF CRL.FINDLAST THEN BEGIN
                        ReportLayoutSelection.SetTempLayoutSelected(FORMAT(CRL."REPORT ID"));
                        Cert.SETFILTER("Employee No.", '%1', Rec."Employee No.");

                        BrojPotvrda := 0;
                        Cert1.RESET;
                        Cert1.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                        IF Cert1.FIND('-') THEN BEGIN
                            BrojPotvrda := Cert1.COUNT;
                        END;
                        //ĐK       Contract416.SetParam("Employee No.",Rec."Agreement Code",0,Rec."Date Of certifications");
                        hr.GET;

                        tempSaveDest := hr."File Path" + "Employee No." + '-' + FORMAT(BrojPotvrda) + '.docx';
                        //ĐK   Contract416.SAVEASWORD(tempSaveDest);
                        FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                        IF Attachment.GET("Attachment No.") THEN
                            Attachment.TESTFIELD("Read Only", FALSE);

                        IF "Attachment No." <> 0 THEN BEGIN
                            IF NOT CONFIRM(Text004, FALSE) THEN
                                EXIT;
                            RemoveAttachment(FALSE);
                            "Attachment No." := 0;
                            MODIFY(FALSE);
                            COMMIT;
                        END;

                        NewAttachNo := AttachmentManagement.InsertAttachment("Attachment No.");
                        IF NewAttachNo <> 0 THEN BEGIN
                            "Attachment No." := NewAttachNo;

                            COMMIT;
                        END;


                    END;
                    ImportAttachment;
                END;

                IF CerAndSol."NAV Agreement Code" = 417 THEN BEGIN


                    CRL.SETFILTER("Report ID", '%1', CerAndSol."NAV Agreement Code");
                    IF CRL.FINDLAST THEN BEGIN
                        ReportLayoutSelection.SetTempLayoutSelected(FORMAT(CRL."REPORT ID"));
                        Cert.SETFILTER("Employee No.", '%1', Rec."Employee No.");

                        BrojPotvrda := 0;
                        Cert1.RESET;
                        Cert1.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                        IF Cert1.FIND('-') THEN BEGIN
                            BrojPotvrda := Cert1.COUNT;
                        END;
                        //ĐK          Contract417.SetParam("Employee No.",Rec."Agreement Code",0,Rec."Date Of certifications");
                        hr.GET;

                        tempSaveDest := hr."File Path" + "Employee No." + '-' + FORMAT(BrojPotvrda) + '.docx';
                        //ĐK      Contract417.SAVEASWORD(tempSaveDest);
                        FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                        IF Attachment.GET("Attachment No.") THEN
                            Attachment.TESTFIELD("Read Only", FALSE);

                        IF "Attachment No." <> 0 THEN BEGIN
                            IF NOT CONFIRM(Text004, FALSE) THEN
                                EXIT;
                            RemoveAttachment(FALSE);
                            "Attachment No." := 0;
                            MODIFY(FALSE);
                            COMMIT;
                        END;

                        NewAttachNo := AttachmentManagement.InsertAttachment("Attachment No.");
                        IF NewAttachNo <> 0 THEN BEGIN
                            "Attachment No." := NewAttachNo;

                            COMMIT;
                        END;


                    END;
                    ImportAttachment;
                END;

                IF CerAndSol."NAV Agreement Code" = 418 THEN BEGIN


                    CRL.SETFILTER("Report ID", '%1', CerAndSol."NAV Agreement Code");
                    IF CRL.FINDLAST THEN BEGIN
                        ReportLayoutSelection.SetTempLayoutSelected(FORMAT(CRL."REPORT ID"));
                        Cert.SETFILTER("Employee No.", '%1', Rec."Employee No.");

                        BrojPotvrda := 0;
                        Cert1.RESET;
                        Cert1.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                        IF Cert1.FIND('-') THEN BEGIN
                            BrojPotvrda := Cert1.COUNT;
                        END;
                        //ĐK         Contract418.SetParam("Employee No.",Rec."Agreement Code",0,Rec."Date Of certifications");
                        hr.GET;

                        tempSaveDest := hr."File Path" + "Employee No." + '-' + FORMAT(BrojPotvrda) + '.docx';
                        //ĐK     Contract418.SAVEASWORD(tempSaveDest);
                        FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                        IF Attachment.GET("Attachment No.") THEN
                            Attachment.TESTFIELD("Read Only", FALSE);

                        IF "Attachment No." <> 0 THEN BEGIN
                            IF NOT CONFIRM(Text004, FALSE) THEN
                                EXIT;
                            RemoveAttachment(FALSE);
                            "Attachment No." := 0;
                            MODIFY(FALSE);
                            COMMIT;
                        END;

                        NewAttachNo := AttachmentManagement.InsertAttachment("Attachment No.");
                        IF NewAttachNo <> 0 THEN BEGIN
                            "Attachment No." := NewAttachNo;

                            COMMIT;
                        END;


                    END;
                    ImportAttachment;
                END;


                IF CerAndSol."NAV Agreement Code" = 491 THEN BEGIN


                    CRL.SETFILTER("Report ID", '%1', CerAndSol."NAV Agreement Code");
                    IF CRL.FINDLAST THEN BEGIN
                        ReportLayoutSelection.SetTempLayoutSelected(FORMAT(CRL."REPORT ID"));
                        Cert.SETFILTER("Employee No.", '%1', Rec."Employee No.");

                        BrojPotvrda := 0;
                        Cert1.RESET;
                        Cert1.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                        IF Cert1.FIND('-') THEN BEGIN
                            BrojPotvrda := Cert1.COUNT;
                        END;
                        //ĐK            Contract491.SetParam("Employee No.",Rec."Agreement Code",0,Rec."Date Of certifications");
                        hr.GET;

                        tempSaveDest := hr."File Path" + "Employee No." + '-' + FORMAT(BrojPotvrda) + '.docx';
                        //ĐK       Contract491.SAVEASWORD(tempSaveDest);
                        FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                        IF Attachment.GET("Attachment No.") THEN
                            Attachment.TESTFIELD("Read Only", FALSE);

                        IF "Attachment No." <> 0 THEN BEGIN
                            IF NOT CONFIRM(Text004, FALSE) THEN
                                EXIT;
                            RemoveAttachment(FALSE);
                            "Attachment No." := 0;
                            MODIFY(FALSE);
                            COMMIT;
                        END;

                        NewAttachNo := AttachmentManagement.InsertAttachment("Attachment No.");
                        IF NewAttachNo <> 0 THEN BEGIN
                            "Attachment No." := NewAttachNo;

                            COMMIT;
                        END;


                    END;
                    ImportAttachment;
                END;

                IF CerAndSol."NAV Agreement Code" = 496 THEN BEGIN


                    CRL.SETFILTER("Report ID", '%1', CerAndSol."NAV Agreement Code");
                    IF CRL.FINDLAST THEN BEGIN
                        ReportLayoutSelection.SetTempLayoutSelected(FORMAT(CRL."REPORT ID"));
                        Cert.SETFILTER("Employee No.", '%1', Rec."Employee No.");

                        BrojPotvrda := 0;
                        Cert1.RESET;
                        Cert1.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                        IF Cert1.FIND('-') THEN BEGIN
                            BrojPotvrda := Cert1.COUNT;
                        END;
                        //ĐK  Contract496.SetParam("Employee No.",Rec."Agreement Code",0,Rec."Date Of certifications");
                        hr.GET;

                        tempSaveDest := hr."File Path" + "Employee No." + '-' + FORMAT(BrojPotvrda) + '.docx';
                        //ĐK  Contract496.SAVEASWORD(tempSaveDest);
                        FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                        IF Attachment.GET("Attachment No.") THEN
                            Attachment.TESTFIELD("Read Only", FALSE);

                        IF "Attachment No." <> 0 THEN BEGIN
                            IF NOT CONFIRM(Text004, FALSE) THEN
                                EXIT;
                            RemoveAttachment(FALSE);
                            "Attachment No." := 0;
                            MODIFY(FALSE);
                            COMMIT;
                        END;

                        NewAttachNo := AttachmentManagement.InsertAttachment("Attachment No.");
                        IF NewAttachNo <> 0 THEN BEGIN
                            "Attachment No." := NewAttachNo;

                            COMMIT;
                        END;


                    END;
                    ImportAttachment;
                END;

                IF CerAndSol."NAV Agreement Code" = 497 THEN BEGIN


                    CRL.SETFILTER("Report ID", '%1', CerAndSol."NAV Agreement Code");
                    IF CRL.FINDLAST THEN BEGIN
                        ReportLayoutSelection.SetTempLayoutSelected(FORMAT(CRL."REPORT ID"));
                        Cert.SETFILTER("Employee No.", '%1', Rec."Employee No.");

                        BrojPotvrda := 0;
                        Cert1.RESET;
                        Cert1.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                        IF Cert1.FIND('-') THEN BEGIN
                            BrojPotvrda := Cert1.COUNT;
                        END;
                        //ĐK Contract497.SetParam("Employee No.",Rec."Agreement Code",0,Rec."Date Of certifications");
                        hr.GET;

                        tempSaveDest := hr."File Path" + "Employee No." + '-' + FORMAT(BrojPotvrda) + '.docx';
                        //ĐK Contract497.SAVEASWORD(tempSaveDest);
                        FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                        IF Attachment.GET("Attachment No.") THEN
                            Attachment.TESTFIELD("Read Only", FALSE);

                        IF "Attachment No." <> 0 THEN BEGIN
                            IF NOT CONFIRM(Text004, FALSE) THEN
                                EXIT;
                            RemoveAttachment(FALSE);
                            "Attachment No." := 0;
                            MODIFY(FALSE);
                            COMMIT;
                        END;

                        NewAttachNo := AttachmentManagement.InsertAttachment("Attachment No.");
                        IF NewAttachNo <> 0 THEN BEGIN
                            "Attachment No." := NewAttachNo;

                            COMMIT;
                        END;


                    END;
                    ImportAttachment;
                END;

                IF CerAndSol."NAV Agreement Code" = 498 THEN BEGIN


                    CRL.SETFILTER("Report ID", '%1', CerAndSol."NAV Agreement Code");
                    IF CRL.FINDLAST THEN BEGIN
                        ReportLayoutSelection.SetTempLayoutSelected(FORMAT(CRL."REPORT ID"));
                        Cert.SETFILTER("Employee No.", '%1', Rec."Employee No.");

                        BrojPotvrda := 0;
                        Cert1.RESET;
                        Cert1.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                        IF Cert1.FIND('-') THEN BEGIN
                            BrojPotvrda := Cert1.COUNT;
                        END;
                        //ĐK   Contract498.SetParam("Employee No.",Rec."Agreement Code",0,Rec."Date Of certifications");
                        hr.GET;

                        tempSaveDest := hr."File Path" + "Employee No." + '-' + FORMAT(BrojPotvrda) + '.docx';
                        //ĐK   Contract498.SAVEASWORD(tempSaveDest);
                        FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                        IF Attachment.GET("Attachment No.") THEN
                            Attachment.TESTFIELD("Read Only", FALSE);

                        IF "Attachment No." <> 0 THEN BEGIN
                            IF NOT CONFIRM(Text004, FALSE) THEN
                                EXIT;
                            RemoveAttachment(FALSE);
                            "Attachment No." := 0;
                            MODIFY(FALSE);
                            COMMIT;
                        END;

                        NewAttachNo := AttachmentManagement.InsertAttachment("Attachment No.");
                        IF NewAttachNo <> 0 THEN BEGIN
                            "Attachment No." := NewAttachNo;

                            COMMIT;
                        END;


                    END;
                    ImportAttachment;
                END;

                IF CerAndSol."NAV Agreement Code" = 499 THEN BEGIN


                    CRL.SETFILTER("Report ID", '%1', CerAndSol."NAV Agreement Code");
                    IF CRL.FINDLAST THEN BEGIN
                        ReportLayoutSelection.SetTempLayoutSelected(FORMAT(CRL."REPORT ID"));
                        Cert.SETFILTER("Employee No.", '%1', Rec."Employee No.");

                        BrojPotvrda := 0;
                        Cert1.RESET;
                        Cert1.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                        IF Cert1.FIND('-') THEN BEGIN
                            BrojPotvrda := Cert1.COUNT;
                        END;
                        //ĐK        Contract499.SetParam("Employee No.",Rec."Agreement Code",0,Rec."Date Of certifications");
                        hr.GET;

                        tempSaveDest := hr."File Path" + "Employee No." + '-' + FORMAT(BrojPotvrda) + '.docx';
                        //ĐK      Contract499.SAVEASWORD(tempSaveDest);
                        FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                        IF Attachment.GET("Attachment No.") THEN
                            Attachment.TESTFIELD("Read Only", FALSE);

                        IF "Attachment No." <> 0 THEN BEGIN
                            IF NOT CONFIRM(Text004, FALSE) THEN
                                EXIT;
                            RemoveAttachment(FALSE);
                            "Attachment No." := 0;
                            MODIFY(FALSE);
                            COMMIT;
                        END;

                        NewAttachNo := AttachmentManagement.InsertAttachment("Attachment No.");
                        IF NewAttachNo <> 0 THEN BEGIN
                            "Attachment No." := NewAttachNo;

                            COMMIT;
                        END;


                    END;
                    ImportAttachment;
                END;



                IF CerAndSol."NAV Agreement Code" = 5064 THEN BEGIN


                    CRL.SETFILTER("Report ID", '%1', CerAndSol."NAV Agreement Code");
                    IF CRL.FINDLAST THEN BEGIN
                        ReportLayoutSelection.SetTempLayoutSelected(FORMAT(CRL."REPORT ID"));
                        Cert.SETFILTER("Employee No.", '%1', Rec."Employee No.");

                        BrojPotvrda := 0;
                        Cert1.RESET;
                        Cert1.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                        Cert1.SETFILTER(Group, '%1', Rec.Group);
                        IF Cert1.FIND('-') THEN BEGIN
                            BrojPotvrda := Cert1.COUNT;
                        END;
                        //ĐK       Contract5064.SetParam("Employee No.",Rec."Agreement Code",0,Rec."Date Of certifications");
                        hr.GET;

                        tempSaveDest := hr."File Path" + "Employee No." + '-' + FORMAT(BrojPotvrda) + '.docx';
                        //ĐK   Contract5064.SAVEASWORD(tempSaveDest);
                        FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                        IF Attachment.GET("Attachment No.") THEN
                            Attachment.TESTFIELD("Read Only", FALSE);

                        IF "Attachment No." <> 0 THEN BEGIN
                            IF NOT CONFIRM(Text004, FALSE) THEN
                                EXIT;
                            RemoveAttachment(FALSE);
                            "Attachment No." := 0;
                            MODIFY(FALSE);
                            COMMIT;
                        END;

                        NewAttachNo := AttachmentManagement.InsertAttachment("Attachment No.");
                        IF NewAttachNo <> 0 THEN BEGIN
                            "Attachment No." := NewAttachNo;

                            COMMIT;
                        END;


                    END;
                    ImportAttachment;
                END;

                IF CerAndSol."NAV Agreement Code" = 5066 THEN BEGIN


                    CRL.SETFILTER("Report ID", '%1', CerAndSol."NAV Agreement Code");
                    IF CRL.FINDLAST THEN BEGIN
                        ReportLayoutSelection.SetTempLayoutSelected(FORMAT(CRL."REPORT ID"));
                        Cert.SETFILTER("Employee No.", '%1', Rec."Employee No.");

                        BrojPotvrda := 0;
                        Cert1.RESET;
                        Cert1.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                        Cert1.SETFILTER(Group, '%1', Rec.Group);
                        IF Cert1.FIND('-') THEN BEGIN
                            BrojPotvrda := Cert1.COUNT;
                        END;
                        //ĐK      Contract5066.SetParam("Employee No.",Rec."Agreement Code",0,Rec."Date Of certifications");
                        hr.GET;

                        tempSaveDest := hr."File Path" + "Employee No." + '-' + FORMAT(BrojPotvrda) + '.docx';
                        //ĐK   Contract5066.SAVEASWORD(tempSaveDest);
                        FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                        IF Attachment.GET("Attachment No.") THEN
                            Attachment.TESTFIELD("Read Only", FALSE);

                        IF "Attachment No." <> 0 THEN BEGIN
                            IF NOT CONFIRM(Text004, FALSE) THEN
                                EXIT;
                            RemoveAttachment(FALSE);
                            "Attachment No." := 0;
                            MODIFY(FALSE);
                            COMMIT;
                        END;

                        NewAttachNo := AttachmentManagement.InsertAttachment("Attachment No.");
                        IF NewAttachNo <> 0 THEN BEGIN
                            "Attachment No." := NewAttachNo;

                            COMMIT;
                        END;


                    END;
                    ImportAttachment;
                END;

                IF CerAndSol."NAV Agreement Code" = 5178 THEN BEGIN


                    CRL.SETFILTER("Report ID", '%1', CerAndSol."NAV Agreement Code");
                    IF CRL.FINDLAST THEN BEGIN
                        ReportLayoutSelection.SetTempLayoutSelected(FORMAT(CRL."REPORT ID"));
                        Cert.SETFILTER("Employee No.", '%1', Rec."Employee No.");

                        BrojPotvrda := 0;
                        Cert1.RESET;
                        Cert1.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                        Cert1.SETFILTER(Group, '%1', Rec.Group);
                        IF Cert1.FIND('-') THEN BEGIN
                            BrojPotvrda := Cert1.COUNT;
                        END;
                        //ĐK       Contract5178.SetParam("Employee No.",Rec."Agreement Code",0,Rec."Date Of certifications");
                        hr.GET;

                        tempSaveDest := hr."File Path" + "Employee No." + '-' + FORMAT(BrojPotvrda) + '.docx';
                        //ĐK    Contract5178.SAVEASWORD(tempSaveDest);
                        FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                        IF Attachment.GET("Attachment No.") THEN
                            Attachment.TESTFIELD("Read Only", FALSE);

                        IF "Attachment No." <> 0 THEN BEGIN
                            IF NOT CONFIRM(Text004, FALSE) THEN
                                EXIT;
                            RemoveAttachment(FALSE);
                            "Attachment No." := 0;
                            MODIFY(FALSE);
                            COMMIT;
                        END;

                        NewAttachNo := AttachmentManagement.InsertAttachment("Attachment No.");
                        IF NewAttachNo <> 0 THEN BEGIN
                            "Attachment No." := NewAttachNo;

                            COMMIT;
                        END;


                    END;
                    ImportAttachment;
                END;


                IF CerAndSol."NAV Agreement Code" = 5179 THEN BEGIN


                    CRL.SETFILTER("Report ID", '%1', CerAndSol."NAV Agreement Code");
                    IF CRL.FINDLAST THEN BEGIN
                        ReportLayoutSelection.SetTempLayoutSelected(FORMAT(CRL."REPORT ID"));
                        Cert.SETFILTER("Employee No.", '%1', Rec."Employee No.");

                        BrojPotvrda := 0;
                        Cert1.RESET;
                        Cert1.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                        Cert1.SETFILTER(Group, '%1', Rec.Group);
                        IF Cert1.FIND('-') THEN BEGIN
                            BrojPotvrda := Cert1.COUNT;
                        END;
                        //ĐK       Contract5179.SetParam("Employee No.",Rec."Agreement Code",0,Rec."Date Of certifications");
                        hr.GET;

                        tempSaveDest := hr."File Path" + "Employee No." + '-' + FORMAT(BrojPotvrda) + '.docx';
                        //ĐK     Contract5179.SAVEASWORD(tempSaveDest);
                        FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                        IF Attachment.GET("Attachment No.") THEN
                            Attachment.TESTFIELD("Read Only", FALSE);

                        IF "Attachment No." <> 0 THEN BEGIN
                            IF NOT CONFIRM(Text004, FALSE) THEN
                                EXIT;
                            RemoveAttachment(FALSE);
                            "Attachment No." := 0;
                            MODIFY(FALSE);
                            COMMIT;
                        END;

                        NewAttachNo := AttachmentManagement.InsertAttachment("Attachment No.");
                        IF NewAttachNo <> 0 THEN BEGIN
                            "Attachment No." := NewAttachNo;

                            COMMIT;
                        END;


                    END;
                    ImportAttachment;
                END;

                IF CerAndSol."NAV Agreement Code" = 5180 THEN BEGIN


                    CRL.SETFILTER("Report ID", '%1', CerAndSol."NAV Agreement Code");
                    IF CRL.FINDLAST THEN BEGIN
                        ReportLayoutSelection.SetTempLayoutSelected(FORMAT(CRL."REPORT ID"));
                        Cert.SETFILTER("Employee No.", '%1', Rec."Employee No.");

                        BrojPotvrda := 0;
                        Cert1.RESET;
                        Cert1.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                        Cert1.SETFILTER(Group, '%1', Rec.Group);
                        IF Cert1.FIND('-') THEN BEGIN
                            BrojPotvrda := Cert1.COUNT;
                        END;
                        //ĐK     Contract5180.SetParam("Employee No.",Rec."Agreement Code",0,Rec."Date Of certifications");
                        hr.GET;

                        tempSaveDest := hr."File Path" + "Employee No." + '-' + FORMAT(BrojPotvrda) + '.docx';
                        //ĐK  Contract5180.SAVEASWORD(tempSaveDest);
                        FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                        IF Attachment.GET("Attachment No.") THEN
                            Attachment.TESTFIELD("Read Only", FALSE);

                        IF "Attachment No." <> 0 THEN BEGIN
                            IF NOT CONFIRM(Text004, FALSE) THEN
                                EXIT;
                            RemoveAttachment(FALSE);
                            "Attachment No." := 0;
                            MODIFY(FALSE);
                            COMMIT;
                        END;

                        NewAttachNo := AttachmentManagement.InsertAttachment("Attachment No.");
                        IF NewAttachNo <> 0 THEN BEGIN
                            "Attachment No." := NewAttachNo;

                            COMMIT;
                        END;


                    END;
                    ImportAttachment;
                END;

                IF CerAndSol."NAV Agreement Code" = 5188 THEN BEGIN


                    CRL.SETFILTER("Report ID", '%1', CerAndSol."NAV Agreement Code");
                    IF CRL.FINDLAST THEN BEGIN
                        ReportLayoutSelection.SetTempLayoutSelected(FORMAT(CRL."REPORT ID"));
                        Cert.SETFILTER("Employee No.", '%1', Rec."Employee No.");

                        BrojPotvrda := 0;
                        Cert1.RESET;
                        Cert1.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                        Cert1.SETFILTER(Group, '%1', Rec.Group);
                        IF Cert1.FIND('-') THEN BEGIN
                            BrojPotvrda := Cert1.COUNT;
                        END;
                        //ĐK      Contract5188.SetParam("Employee No.",Rec."Agreement Code",0,Rec."Date Of certifications");
                        hr.GET;

                        tempSaveDest := hr."File Path" + "Employee No." + '-' + FORMAT(BrojPotvrda) + '.docx';
                        //ĐK   Contract5188.SAVEASWORD(tempSaveDest);
                        FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                        IF Attachment.GET("Attachment No.") THEN
                            Attachment.TESTFIELD("Read Only", FALSE);

                        IF "Attachment No." <> 0 THEN BEGIN
                            IF NOT CONFIRM(Text004, FALSE) THEN
                                EXIT;
                            RemoveAttachment(FALSE);
                            "Attachment No." := 0;
                            MODIFY(FALSE);
                            COMMIT;
                        END;

                        NewAttachNo := AttachmentManagement.InsertAttachment("Attachment No.");
                        IF NewAttachNo <> 0 THEN BEGIN
                            "Attachment No." := NewAttachNo;

                            COMMIT;
                        END;


                    END;
                    ImportAttachment;
                END;

                IF CerAndSol."NAV Agreement Code" = 5189 THEN BEGIN


                    CRL.SETFILTER("Report ID", '%1', CerAndSol."NAV Agreement Code");
                    IF CRL.FINDLAST THEN BEGIN
                        ReportLayoutSelection.SetTempLayoutSelected(FORMAT(CRL."REPORT ID"));
                        Cert.SETFILTER("Employee No.", '%1', Rec."Employee No.");

                        BrojPotvrda := 0;
                        Cert1.RESET;
                        Cert1.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                        Cert1.SETFILTER(Group, '%1', Rec.Group);
                        IF Cert1.FIND('-') THEN BEGIN
                            BrojPotvrda := Cert1.COUNT;
                        END;
                        //ĐK        Contract5189.SetParam("Employee No.",Rec."Agreement Code",0,Rec."Date Of certifications");
                        hr.GET;

                        tempSaveDest := hr."File Path" + "Employee No." + '-' + FORMAT(BrojPotvrda) + '.docx';
                        //ĐK     Contract5189.SAVEASWORD(tempSaveDest);
                        FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                        IF Attachment.GET("Attachment No.") THEN
                            Attachment.TESTFIELD("Read Only", FALSE);

                        IF "Attachment No." <> 0 THEN BEGIN
                            IF NOT CONFIRM(Text004, FALSE) THEN
                                EXIT;
                            RemoveAttachment(FALSE);
                            "Attachment No." := 0;
                            MODIFY(FALSE);
                            COMMIT;
                        END;

                        NewAttachNo := AttachmentManagement.InsertAttachment("Attachment No.");
                        IF NewAttachNo <> 0 THEN BEGIN
                            "Attachment No." := NewAttachNo;

                            COMMIT;
                        END;


                    END;
                    ImportAttachment;
                END;

                IF CerAndSol."NAV Agreement Code" = 5190 THEN BEGIN


                    CRL.SETFILTER("Report ID", '%1', CerAndSol."NAV Agreement Code");
                    IF CRL.FINDLAST THEN BEGIN
                        ReportLayoutSelection.SetTempLayoutSelected(FORMAT(CRL."REPORT ID"));
                        Cert.SETFILTER("Employee No.", '%1', Rec."Employee No.");

                        BrojPotvrda := 0;
                        Cert1.RESET;
                        Cert1.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                        Cert1.SETFILTER(Group, '%1', Rec.Group);
                        IF Cert1.FIND('-') THEN BEGIN
                            BrojPotvrda := Cert1.COUNT;
                        END;
                        //ĐK        Contract5190.SetParam("Employee No.",Rec."Agreement Code",0,Rec."Date Of certifications");
                        hr.GET;

                        tempSaveDest := hr."File Path" + "Employee No." + '-' + FORMAT(BrojPotvrda) + '.docx';
                        //ĐK    Contract5190.SAVEASWORD(tempSaveDest);
                        FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                        IF Attachment.GET("Attachment No.") THEN
                            Attachment.TESTFIELD("Read Only", FALSE);

                        IF "Attachment No." <> 0 THEN BEGIN
                            IF NOT CONFIRM(Text004, FALSE) THEN
                                EXIT;
                            RemoveAttachment(FALSE);
                            "Attachment No." := 0;
                            MODIFY(FALSE);
                            COMMIT;
                        END;

                        NewAttachNo := AttachmentManagement.InsertAttachment("Attachment No.");
                        IF NewAttachNo <> 0 THEN BEGIN
                            "Attachment No." := NewAttachNo;

                            COMMIT;
                        END;


                    END;
                    ImportAttachment;
                END;

                IF CerAndSol."NAV Agreement Code" = 5193 THEN BEGIN


                    CRL.SETFILTER("Report ID", '%1', CerAndSol."NAV Agreement Code");
                    IF CRL.FINDLAST THEN BEGIN
                        ReportLayoutSelection.SetTempLayoutSelected(FORMAT(CRL."REPORT ID"));
                        Cert.SETFILTER("Employee No.", '%1', Rec."Employee No.");

                        BrojPotvrda := 0;
                        Cert1.RESET;
                        Cert1.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                        Cert1.SETFILTER(Group, '%1', Rec.Group);
                        IF Cert1.FIND('-') THEN BEGIN
                            BrojPotvrda := Cert1.COUNT;
                        END;
                        //ĐK        Contract5193.SetParam("Employee No.",Rec."Agreement Code",0,Rec."Date Of certifications");
                        hr.GET;

                        tempSaveDest := hr."File Path" + "Employee No." + '-' + FORMAT(BrojPotvrda) + '.docx';
                        //ĐK      Contract5193.SAVEASWORD(tempSaveDest);
                        FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                        IF Attachment.GET("Attachment No.") THEN
                            Attachment.TESTFIELD("Read Only", FALSE);

                        IF "Attachment No." <> 0 THEN BEGIN
                            IF NOT CONFIRM(Text004, FALSE) THEN
                                EXIT;
                            RemoveAttachment(FALSE);
                            "Attachment No." := 0;
                            MODIFY(FALSE);
                            COMMIT;
                        END;

                        NewAttachNo := AttachmentManagement.InsertAttachment("Attachment No.");
                        IF NewAttachNo <> 0 THEN BEGIN
                            "Attachment No." := NewAttachNo;

                            COMMIT;
                        END;


                    END;
                    ImportAttachment;
                END;

                IF CerAndSol."NAV Agreement Code" = 5194 THEN BEGIN


                    CRL.SETFILTER("Report ID", '%1', CerAndSol."NAV Agreement Code");
                    IF CRL.FINDLAST THEN BEGIN
                        ReportLayoutSelection.SetTempLayoutSelected(FORMAT(CRL."REPORT ID"));
                        Cert.SETFILTER("Employee No.", '%1', Rec."Employee No.");

                        BrojPotvrda := 0;
                        Cert1.RESET;
                        Cert1.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                        Cert1.SETFILTER(Group, '%1', Rec.Group);
                        IF Cert1.FIND('-') THEN BEGIN
                            BrojPotvrda := Cert1.COUNT;
                        END;
                        //ĐK         Contract5194.SetParam("Employee No.",Rec."Agreement Code",0,Rec."Date Of certifications");
                        hr.GET;

                        tempSaveDest := hr."File Path" + "Employee No." + '-' + FORMAT(BrojPotvrda) + '.docx';
                        //ĐK     Contract5194.SAVEASWORD(tempSaveDest);
                        FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                        IF Attachment.GET("Attachment No.") THEN
                            Attachment.TESTFIELD("Read Only", FALSE);

                        IF "Attachment No." <> 0 THEN BEGIN
                            IF NOT CONFIRM(Text004, FALSE) THEN
                                EXIT;
                            RemoveAttachment(FALSE);
                            "Attachment No." := 0;
                            MODIFY(FALSE);
                            COMMIT;
                        END;

                        NewAttachNo := AttachmentManagement.InsertAttachment("Attachment No.");
                        IF NewAttachNo <> 0 THEN BEGIN
                            "Attachment No." := NewAttachNo;

                            COMMIT;
                        END;


                    END;
                    ImportAttachment;
                END;

                IF CerAndSol."NAV Agreement Code" = 5195 THEN BEGIN


                    CRL.SETFILTER("Report ID", '%1', CerAndSol."NAV Agreement Code");
                    IF CRL.FINDLAST THEN BEGIN
                        ReportLayoutSelection.SetTempLayoutSelected(FORMAT(CRL."REPORT ID"));
                        Cert.SETFILTER("Employee No.", '%1', Rec."Employee No.");

                        BrojPotvrda := 0;
                        Cert1.RESET;
                        Cert1.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                        Cert1.SETFILTER(Group, '%1', Rec.Group);
                        IF Cert1.FIND('-') THEN BEGIN
                            BrojPotvrda := Cert1.COUNT;
                        END;
                        //ĐK        Contract5195.SetParam("Employee No.",Rec."Agreement Code",0,Rec."Date Of certifications");
                        hr.GET;

                        tempSaveDest := hr."File Path" + "Employee No." + '-' + FORMAT(BrojPotvrda) + '.docx';
                        //ĐK      Contract5195.SAVEASWORD(tempSaveDest);
                        FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                        IF Attachment.GET("Attachment No.") THEN
                            Attachment.TESTFIELD("Read Only", FALSE);

                        IF "Attachment No." <> 0 THEN BEGIN
                            IF NOT CONFIRM(Text004, FALSE) THEN
                                EXIT;
                            RemoveAttachment(FALSE);
                            "Attachment No." := 0;
                            MODIFY(FALSE);
                            COMMIT;
                        END;

                        NewAttachNo := AttachmentManagement.InsertAttachment("Attachment No.");
                        IF NewAttachNo <> 0 THEN BEGIN
                            "Attachment No." := NewAttachNo;

                            COMMIT;
                        END;


                    END;
                    ImportAttachment;
                END;

                IF CerAndSol."NAV Agreement Code" = 5196 THEN BEGIN


                    CRL.SETFILTER("Report ID", '%1', CerAndSol."NAV Agreement Code");
                    IF CRL.FINDLAST THEN BEGIN
                        ReportLayoutSelection.SetTempLayoutSelected(FORMAT(CRL."REPORT ID"));
                        Cert.SETFILTER("Employee No.", '%1', Rec."Employee No.");

                        BrojPotvrda := 0;
                        Cert1.RESET;
                        Cert1.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                        Cert1.SETFILTER(Group, '%1', Rec.Group);
                        IF Cert1.FIND('-') THEN BEGIN
                            BrojPotvrda := Cert1.COUNT;
                        END;
                        //ĐK        Contract5196.SetParam("Employee No.",Rec."Agreement Code",0,Rec."Date Of certifications");
                        hr.GET;

                        tempSaveDest := hr."File Path" + "Employee No." + '-' + FORMAT(BrojPotvrda) + '.docx';
                        //ĐK   Contract5196.SAVEASWORD(tempSaveDest);
                        FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                        IF Attachment.GET("Attachment No.") THEN
                            Attachment.TESTFIELD("Read Only", FALSE);

                        IF "Attachment No." <> 0 THEN BEGIN
                            IF NOT CONFIRM(Text004, FALSE) THEN
                                EXIT;
                            RemoveAttachment(FALSE);
                            "Attachment No." := 0;
                            MODIFY(FALSE);
                            COMMIT;
                        END;

                        NewAttachNo := AttachmentManagement.InsertAttachment("Attachment No.");
                        IF NewAttachNo <> 0 THEN BEGIN
                            "Attachment No." := NewAttachNo;

                            COMMIT;
                        END;


                    END;
                    ImportAttachment;
                END;

                IF CerAndSol."NAV Agreement Code" = 5197 THEN BEGIN


                    CRL.SETFILTER("Report ID", '%1', CerAndSol."NAV Agreement Code");
                    IF CRL.FINDLAST THEN BEGIN
                        ReportLayoutSelection.SetTempLayoutSelected(FORMAT(CRL."REPORT ID"));
                        Cert.SETFILTER("Employee No.", '%1', Rec."Employee No.");

                        BrojPotvrda := 0;
                        Cert1.RESET;
                        Cert1.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                        Cert1.SETFILTER(Group, '%1', Rec.Group);
                        IF Cert1.FIND('-') THEN BEGIN
                            BrojPotvrda := Cert1.COUNT;
                        END;
                        //ĐK      Contract5197.SetParam("Employee No.",Rec."Agreement Code",0,Rec."Date Of certifications");
                        hr.GET;

                        tempSaveDest := hr."File Path" + "Employee No." + '-' + FORMAT(BrojPotvrda) + '.docx';
                        //ĐK    Contract5197.SAVEASWORD(tempSaveDest);
                        FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                        IF Attachment.GET("Attachment No.") THEN
                            Attachment.TESTFIELD("Read Only", FALSE);

                        IF "Attachment No." <> 0 THEN BEGIN
                            IF NOT CONFIRM(Text004, FALSE) THEN
                                EXIT;
                            RemoveAttachment(FALSE);
                            "Attachment No." := 0;
                            MODIFY(FALSE);
                            COMMIT;
                        END;

                        NewAttachNo := AttachmentManagement.InsertAttachment("Attachment No.");
                        IF NewAttachNo <> 0 THEN BEGIN
                            "Attachment No." := NewAttachNo;

                            COMMIT;
                        END;


                    END;
                    ImportAttachment;
                END;

                IF CerAndSol."NAV Agreement Code" = 5198 THEN BEGIN


                    CRL.SETFILTER("Report ID", '%1', CerAndSol."NAV Agreement Code");
                    IF CRL.FINDLAST THEN BEGIN
                        ReportLayoutSelection.SetTempLayoutSelected(FORMAT(CRL."REPORT ID"));
                        Cert.SETFILTER("Employee No.", '%1', Rec."Employee No.");

                        BrojPotvrda := 0;
                        Cert1.RESET;
                        Cert1.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                        Cert1.SETFILTER(Group, '%1', Rec.Group);
                        IF Cert1.FIND('-') THEN BEGIN
                            BrojPotvrda := Cert1.COUNT;
                        END;
                        //ĐK       Contract5198.SetParam("Employee No.",Rec."Agreement Code",0,Rec."Date Of certifications");
                        hr.GET;

                        tempSaveDest := hr."File Path" + "Employee No." + '-' + FORMAT(BrojPotvrda) + '.docx';
                        //ĐK    Contract5198.SAVEASWORD(tempSaveDest);
                        FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                        IF Attachment.GET("Attachment No.") THEN
                            Attachment.TESTFIELD("Read Only", FALSE);

                        IF "Attachment No." <> 0 THEN BEGIN
                            IF NOT CONFIRM(Text004, FALSE) THEN
                                EXIT;
                            RemoveAttachment(FALSE);
                            "Attachment No." := 0;
                            MODIFY(FALSE);
                            COMMIT;
                        END;

                        NewAttachNo := AttachmentManagement.InsertAttachment("Attachment No.");
                        IF NewAttachNo <> 0 THEN BEGIN
                            "Attachment No." := NewAttachNo;

                            COMMIT;
                        END;


                    END;
                    ImportAttachment;
                END;

                IF CerAndSol."NAV Agreement Code" = 5199 THEN BEGIN


                    CRL.SETFILTER("Report ID", '%1', CerAndSol."NAV Agreement Code");
                    IF CRL.FINDLAST THEN BEGIN
                        ReportLayoutSelection.SetTempLayoutSelected(FORMAT(CRL."REPORT ID"));
                        Cert.SETFILTER("Employee No.", '%1', Rec."Employee No.");

                        BrojPotvrda := 0;
                        Cert1.RESET;
                        Cert1.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                        Cert1.SETFILTER(Group, '%1', Rec.Group);
                        IF Cert1.FIND('-') THEN BEGIN
                            BrojPotvrda := Cert1.COUNT;
                        END;
                        //ĐK       Contract5199.SetParam("Employee No.",Rec."Agreement Code",0,Rec."Date Of certifications");
                        hr.GET;

                        tempSaveDest := hr."File Path" + "Employee No." + '-' + FORMAT(BrojPotvrda) + '.docx';
                        //ĐK   Contract5199.SAVEASWORD(tempSaveDest);
                        FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                        IF Attachment.GET("Attachment No.") THEN
                            Attachment.TESTFIELD("Read Only", FALSE);

                        IF "Attachment No." <> 0 THEN BEGIN
                            IF NOT CONFIRM(Text004, FALSE) THEN
                                EXIT;
                            RemoveAttachment(FALSE);
                            "Attachment No." := 0;
                            MODIFY(FALSE);
                            COMMIT;
                        END;

                        NewAttachNo := AttachmentManagement.InsertAttachment("Attachment No.");
                        IF NewAttachNo <> 0 THEN BEGIN
                            "Attachment No." := NewAttachNo;

                            COMMIT;
                        END;


                    END;
                    ImportAttachment;
                END;

                IF CerAndSol."NAV Agreement Code" = 5606 THEN BEGIN


                    CRL.SETFILTER("Report ID", '%1', CerAndSol."NAV Agreement Code");
                    IF CRL.FINDLAST THEN BEGIN
                        ReportLayoutSelection.SetTempLayoutSelected(FORMAT(CRL."REPORT ID"));
                        Cert.SETFILTER("Employee No.", '%1', Rec."Employee No.");

                        BrojPotvrda := 0;
                        Cert1.RESET;
                        Cert1.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                        Cert1.SETFILTER(Group, '%1', Rec.Group);
                        IF Cert1.FIND('-') THEN BEGIN
                            BrojPotvrda := Cert1.COUNT;
                        END;
                        //ĐK      Contract5606.SetParam("Employee No.",Rec."Agreement Code",0,Rec."Date Of certifications");
                        hr.GET;

                        tempSaveDest := hr."File Path" + "Employee No." + '-' + FORMAT(BrojPotvrda) + '.docx';
                        //ĐK     Contract5606.SAVEASWORD(tempSaveDest);
                        FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                        IF Attachment.GET("Attachment No.") THEN
                            Attachment.TESTFIELD("Read Only", FALSE);

                        IF "Attachment No." <> 0 THEN BEGIN
                            IF NOT CONFIRM(Text004, FALSE) THEN
                                EXIT;
                            RemoveAttachment(FALSE);
                            "Attachment No." := 0;
                            MODIFY(FALSE);
                            COMMIT;
                        END;

                        NewAttachNo := AttachmentManagement.InsertAttachment("Attachment No.");
                        IF NewAttachNo <> 0 THEN BEGIN
                            "Attachment No." := NewAttachNo;

                            COMMIT;
                        END;


                    END;
                    ImportAttachment;
                END;

                IF CerAndSol."NAV Agreement Code" = 5607 THEN BEGIN


                    CRL.SETFILTER("Report ID", '%1', CerAndSol."NAV Agreement Code");
                    IF CRL.FINDLAST THEN BEGIN
                        ReportLayoutSelection.SetTempLayoutSelected(FORMAT(CRL."REPORT ID"));
                        Cert.SETFILTER("Employee No.", '%1', Rec."Employee No.");

                        BrojPotvrda := 0;
                        Cert1.RESET;
                        Cert1.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                        Cert1.SETFILTER(Group, '%1', Rec.Group);
                        IF Cert1.FIND('-') THEN BEGIN
                            BrojPotvrda := Cert1.COUNT;
                        END;
                        //ĐK       Contract5607.SetParam("Employee No.",Rec."Agreement Code",0,Rec."Date Of certifications");
                        hr.GET;

                        tempSaveDest := hr."File Path" + "Employee No." + '-' + FORMAT(BrojPotvrda) + '.docx';
                        //ĐK     Contract5607.SAVEASWORD(tempSaveDest);
                        FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                        IF Attachment.GET("Attachment No.") THEN
                            Attachment.TESTFIELD("Read Only", FALSE);

                        IF "Attachment No." <> 0 THEN BEGIN
                            IF NOT CONFIRM(Text004, FALSE) THEN
                                EXIT;
                            RemoveAttachment(FALSE);
                            "Attachment No." := 0;
                            MODIFY(FALSE);
                            COMMIT;
                        END;

                        NewAttachNo := AttachmentManagement.InsertAttachment("Attachment No.");
                        IF NewAttachNo <> 0 THEN BEGIN
                            "Attachment No." := NewAttachNo;

                            COMMIT;
                        END;


                    END;
                    ImportAttachment;
                END;

                IF CerAndSol."NAV Agreement Code" = 5608 THEN BEGIN


                    CRL.SETFILTER("Report ID", '%1', CerAndSol."NAV Agreement Code");
                    IF CRL.FINDLAST THEN BEGIN
                        ReportLayoutSelection.SetTempLayoutSelected(FORMAT(CRL."REPORT ID"));
                        Cert.SETFILTER("Employee No.", '%1', Rec."Employee No.");

                        BrojPotvrda := 0;
                        Cert1.RESET;
                        Cert1.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                        Cert1.SETFILTER(Group, '%1', Rec.Group);
                        IF Cert1.FIND('-') THEN BEGIN
                            BrojPotvrda := Cert1.COUNT;
                        END;
                        //ĐK         Contract5608.SetParam("Employee No.",Rec."Agreement Code",0,Rec."Date Of certifications");
                        hr.GET;

                        tempSaveDest := hr."File Path" + "Employee No." + '-' + FORMAT(BrojPotvrda) + '.docx';
                        //ĐK     Contract5608.SAVEASWORD(tempSaveDest);
                        FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                        IF Attachment.GET("Attachment No.") THEN
                            Attachment.TESTFIELD("Read Only", FALSE);

                        IF "Attachment No." <> 0 THEN BEGIN
                            IF NOT CONFIRM(Text004, FALSE) THEN
                                EXIT;
                            RemoveAttachment(FALSE);
                            "Attachment No." := 0;
                            MODIFY(FALSE);
                            COMMIT;
                        END;

                        NewAttachNo := AttachmentManagement.InsertAttachment("Attachment No.");
                        IF NewAttachNo <> 0 THEN BEGIN
                            "Attachment No." := NewAttachNo;

                            COMMIT;
                        END;


                    END;
                    ImportAttachment;
                END;

                IF CerAndSol."NAV Agreement Code" = 5610 THEN BEGIN


                    CRL.SETFILTER("Report ID", '%1', CerAndSol."NAV Agreement Code");
                    IF CRL.FINDLAST THEN BEGIN
                        ReportLayoutSelection.SetTempLayoutSelected(FORMAT(CRL."REPORT ID"));
                        Cert.SETFILTER("Employee No.", '%1', Rec."Employee No.");

                        BrojPotvrda := 0;
                        Cert1.RESET;
                        Cert1.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                        Cert1.SETFILTER(Group, '%1', Rec.Group);
                        IF Cert1.FIND('-') THEN BEGIN
                            BrojPotvrda := Cert1.COUNT;
                        END;
                        //ĐK        Contract5610.SetParam("Employee No.",Rec."Agreement Code",0,Rec."Date Of certifications");
                        hr.GET;

                        tempSaveDest := hr."File Path" + "Employee No." + '-' + FORMAT(BrojPotvrda) + '.docx';
                        //ĐK     Contract5610.SAVEASWORD(tempSaveDest);
                        FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                        IF Attachment.GET("Attachment No.") THEN
                            Attachment.TESTFIELD("Read Only", FALSE);

                        IF "Attachment No." <> 0 THEN BEGIN
                            IF NOT CONFIRM(Text004, FALSE) THEN
                                EXIT;
                            RemoveAttachment(FALSE);
                            "Attachment No." := 0;
                            MODIFY(FALSE);
                            COMMIT;
                        END;

                        NewAttachNo := AttachmentManagement.InsertAttachment("Attachment No.");
                        IF NewAttachNo <> 0 THEN BEGIN
                            "Attachment No." := NewAttachNo;

                            COMMIT;
                        END;


                    END;
                    ImportAttachment;
                END;

                IF CerAndSol."NAV Agreement Code" = 5611 THEN BEGIN


                    CRL.SETFILTER("Report ID", '%1', CerAndSol."NAV Agreement Code");
                    IF CRL.FINDLAST THEN BEGIN
                        ReportLayoutSelection.SetTempLayoutSelected(FORMAT(CRL."REPORT ID"));
                        Cert.SETFILTER("Employee No.", '%1', Rec."Employee No.");

                        BrojPotvrda := 0;
                        Cert1.RESET;
                        Cert1.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                        Cert1.SETFILTER(Group, '%1', Rec.Group);
                        IF Cert1.FIND('-') THEN BEGIN
                            BrojPotvrda := Cert1.COUNT;
                        END;
                        //ĐK        Contract5611.SetParam("Employee No.",Rec."Agreement Code",0,Rec."Date Of certifications");
                        hr.GET;

                        tempSaveDest := hr."File Path" + "Employee No." + '-' + FORMAT(BrojPotvrda) + '.docx';
                        //ĐK      Contract5611.SAVEASWORD(tempSaveDest);
                        FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                        IF Attachment.GET("Attachment No.") THEN
                            Attachment.TESTFIELD("Read Only", FALSE);

                        IF "Attachment No." <> 0 THEN BEGIN
                            IF NOT CONFIRM(Text004, FALSE) THEN
                                EXIT;
                            RemoveAttachment(FALSE);
                            "Attachment No." := 0;
                            MODIFY(FALSE);
                            COMMIT;
                        END;

                        NewAttachNo := AttachmentManagement.InsertAttachment("Attachment No.");
                        IF NewAttachNo <> 0 THEN BEGIN
                            "Attachment No." := NewAttachNo;

                            COMMIT;
                        END;


                    END;
                    ImportAttachment;
                END;

                IF CerAndSol."NAV Agreement Code" = 5620 THEN BEGIN


                    CRL.SETFILTER("Report ID", '%1', CerAndSol."NAV Agreement Code");
                    IF CRL.FINDLAST THEN BEGIN
                        ReportLayoutSelection.SetTempLayoutSelected(FORMAT(CRL."REPORT ID"));
                        Cert.SETFILTER("Employee No.", '%1', Rec."Employee No.");

                        BrojPotvrda := 0;
                        Cert1.RESET;
                        Cert1.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                        Cert1.SETFILTER(Group, '%1', Rec.Group);
                        IF Cert1.FIND('-') THEN BEGIN
                            BrojPotvrda := Cert1.COUNT;
                        END;
                        //ĐK          Contract5620.SetParam("Employee No.",Rec."Agreement Code",0,Rec."Date Of certifications");
                        hr.GET;

                        tempSaveDest := hr."File Path" + "Employee No." + '-' + FORMAT(BrojPotvrda) + '.docx';
                        //ĐK     Contract5620.SAVEASWORD(tempSaveDest);
                        FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                        IF Attachment.GET("Attachment No.") THEN
                            Attachment.TESTFIELD("Read Only", FALSE);

                        IF "Attachment No." <> 0 THEN BEGIN
                            IF NOT CONFIRM(Text004, FALSE) THEN
                                EXIT;
                            RemoveAttachment(FALSE);
                            "Attachment No." := 0;
                            MODIFY(FALSE);
                            COMMIT;
                        END;

                        NewAttachNo := AttachmentManagement.InsertAttachment("Attachment No.");
                        IF NewAttachNo <> 0 THEN BEGIN
                            "Attachment No." := NewAttachNo;

                            COMMIT;
                        END;


                    END;
                    ImportAttachment;
                END;

                IF CerAndSol."NAV Agreement Code" = 5621 THEN BEGIN


                    CRL.SETFILTER("Report ID", '%1', CerAndSol."NAV Agreement Code");
                    IF CRL.FINDLAST THEN BEGIN
                        ReportLayoutSelection.SetTempLayoutSelected(FORMAT(CRL."REPORT ID"));
                        Cert.SETFILTER("Employee No.", '%1', Rec."Employee No.");

                        BrojPotvrda := 0;
                        Cert1.RESET;
                        Cert1.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                        Cert1.SETFILTER(Group, '%1', Rec.Group);
                        IF Cert1.FIND('-') THEN BEGIN
                            BrojPotvrda := Cert1.COUNT;
                        END;
                        //ĐK        Contract5621.SetParam("Employee No.",Rec."Agreement Code",0,Rec."Date Of certifications");
                        hr.GET;

                        tempSaveDest := hr."File Path" + "Employee No." + '-' + FORMAT(BrojPotvrda) + '.docx';
                        //ĐK      Contract5621.SAVEASWORD(tempSaveDest);
                        FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                        IF Attachment.GET("Attachment No.") THEN
                            Attachment.TESTFIELD("Read Only", FALSE);

                        IF "Attachment No." <> 0 THEN BEGIN
                            IF NOT CONFIRM(Text004, FALSE) THEN
                                EXIT;
                            RemoveAttachment(FALSE);
                            "Attachment No." := 0;
                            MODIFY(FALSE);
                            COMMIT;
                        END;

                        NewAttachNo := AttachmentManagement.InsertAttachment("Attachment No.");
                        IF NewAttachNo <> 0 THEN BEGIN
                            "Attachment No." := NewAttachNo;

                            COMMIT;
                        END;


                    END;
                    ImportAttachment;
                END;

                IF CerAndSol."NAV Agreement Code" = 5622 THEN BEGIN


                    CRL.SETFILTER("Report ID", '%1', CerAndSol."NAV Agreement Code");
                    IF CRL.FINDLAST THEN BEGIN
                        ReportLayoutSelection.SetTempLayoutSelected(FORMAT(CRL."REPORT ID"));
                        Cert.SETFILTER("Employee No.", '%1', Rec."Employee No.");

                        BrojPotvrda := 0;
                        Cert1.RESET;
                        Cert1.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                        Cert1.SETFILTER(Group, '%1', Rec.Group);
                        IF Cert1.FIND('-') THEN BEGIN
                            BrojPotvrda := Cert1.COUNT;
                        END;
                        //ĐK           Contract5622.SetParam("Employee No.",Rec."Agreement Code",0,Rec."Date Of certifications");
                        hr.GET;

                        tempSaveDest := hr."File Path" + "Employee No." + '-' + FORMAT(BrojPotvrda) + '.docx';
                        //ĐK       Contract5622.SAVEASWORD(tempSaveDest);
                        FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                        IF Attachment.GET("Attachment No.") THEN
                            Attachment.TESTFIELD("Read Only", FALSE);

                        IF "Attachment No." <> 0 THEN BEGIN
                            IF NOT CONFIRM(Text004, FALSE) THEN
                                EXIT;
                            RemoveAttachment(FALSE);
                            "Attachment No." := 0;
                            MODIFY(FALSE);
                            COMMIT;
                        END;

                        NewAttachNo := AttachmentManagement.InsertAttachment("Attachment No.");
                        IF NewAttachNo <> 0 THEN BEGIN
                            "Attachment No." := NewAttachNo;

                            COMMIT;
                        END;


                    END;
                    ImportAttachment;
                END;

                IF CerAndSol."NAV Agreement Code" = 5623 THEN BEGIN


                    CRL.SETFILTER("Report ID", '%1', CerAndSol."NAV Agreement Code");
                    IF CRL.FINDLAST THEN BEGIN
                        ReportLayoutSelection.SetTempLayoutSelected(FORMAT(CRL."REPORT ID"));
                        Cert.SETFILTER("Employee No.", '%1', Rec."Employee No.");

                        BrojPotvrda := 0;
                        Cert1.RESET;
                        Cert1.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                        Cert1.SETFILTER(Group, '%1', Rec.Group);
                        IF Cert1.FIND('-') THEN BEGIN
                            BrojPotvrda := Cert1.COUNT;
                        END;
                        //ĐK       Contract5623.SetParam("Employee No.",Rec."Agreement Code",0,Rec."Date Of certifications");
                        hr.GET;

                        tempSaveDest := hr."File Path" + "Employee No." + '-' + FORMAT(BrojPotvrda) + '.docx';
                        //ĐK    Contract5623.SAVEASWORD(tempSaveDest);
                        FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                        IF Attachment.GET("Attachment No.") THEN
                            Attachment.TESTFIELD("Read Only", FALSE);

                        IF "Attachment No." <> 0 THEN BEGIN
                            IF NOT CONFIRM(Text004, FALSE) THEN
                                EXIT;
                            RemoveAttachment(FALSE);
                            "Attachment No." := 0;
                            MODIFY(FALSE);
                            COMMIT;
                        END;

                        NewAttachNo := AttachmentManagement.InsertAttachment("Attachment No.");
                        IF NewAttachNo <> 0 THEN BEGIN
                            "Attachment No." := NewAttachNo;

                            COMMIT;
                        END;


                    END;
                    ImportAttachment;
                END;
            end;
        }
        field(50023; ID; Integer)
        {
            AutoIncrement = true;
        }
        field(50024; "Date Of certifications"; Date)
        {
            Caption = 'Date Of certifications';
        }
        field(50025; "NAV Agreement Code"; Integer)
        {
            Caption = 'Agreement code';
        }
        field(50026; "Attachment No."; Integer)
        {
        }
        field(50405; Change; Boolean)
        {
            Caption = 'Change';
        }
        field(50406; "Number for Certification"; Integer)
        {
            Caption = 'Number for Certification';
        }
    }

    keys
    {
        key(Key1; "Employee No.", "Document Description", "Agreement Code", ID)
        {
        }
        key(Key2; "Document Description")
        {
        }
    }

    fieldgroups
    {

    }

    trigger OnDelete()
    var
        HRCommentLine: Record "Human Resource Comment Line";
    begin
    end;

    trigger OnInsert()
    begin
        "Date Of Input Info" := TODAY;
        "Number for Certification" := 2;
    end;

    var
        Employee: Record "Employee";
        EmployeeRelative: Record "Employee Relative";
        Relative: Record "Relative";
        CerAndSol: Record "Certication and solu";
        Text001: Label 'End Date must not be before Start date.';
        InteractTmplLanguage: Record "Awards";
        Attachment: Record "Attachment";
        AttachmentManagement: Codeunit "AttachmentManagement";
        CertCheck: Record "Certifications r";
        BrojPotvrda: Integer;
        Text004: Label 'Replace existing attachment?';
        AttachmentRecord: Record "Attachment";
        Text005: Label 'You have canceled the import process.';
        Text006: Label 'Export Attachment';
        //ĐK ContractR: Report "60524";
        DR: Record "Certication and solu";
        Cert: Record "Certifications r";
        Cert1: Record "Certifications r";
        FileManagement: Codeunit "File Management";
        CRL: Record "Custom Report Layout";
        ReportLayoutSelection: Record "Report Layout Selection";
        tempSaveDest: Text;
        Text000: Label 'Start Date must have value.';
        Text002: Label 'Personalni broj ne smije biti prazan!';
        Text003: Label 'You have canceled the create process.';
        Text007: Label 'Da li ste sigurni da zelite promijeniti vrijednost polja iz %1 u %2?';
        NewAttachNo: Integer;
        //ĐK Contract2Rreport: Report "60525";
        //ĐK  Contract3: Report "60526";
        //ContractStazIStrucna: Report "65549";
        // ContractOPlacenomFBIH: Report "65550";
        hr: Record "Human Resources Setup";
    /*Contract5062: Report "5062";
    Contract88: Report "88";
    Contract87: Report "87";
    Contract115: Report "115";
    Contract129: Report "129";
    Contract187: Report "187";
    Contract188: Report "188";
    Contract189: Report "189";
    Contract190: Report "190";
    Contract191: Report "191";
    Contract192: Report "192";
    Contract193: Report "193";
    Contract215: Report "215";
    Contract216: Report "216";
    Contract291: Report "291";
    Contract292: Report "292";
    Contract296: Report "296";
    Contract297: Report "297";
    Contract319: Report "319";
    Contract322: Report "322";
    Contract324: Report "324";
    Contract406: Report "406";
    Contract407: Report "407";
    Contract408: Report "408";
    Contract410: Report "410";
    Contract412: Report "412";
    Contract415: Report "415";
    Contract416: Report "416";
    Contract417: Report "417";
    Contract418: Report "418";
    Contract491: Report "491";
    Contract496: Report "496";
    Contract497: Report "497";
    Contract498: Report "498";
    Contract499: Report "499";
    Contract298: Report "298";
    Contract5064: Report "5064";
    Contract5066: Report "5066";
    Contract5178: Report "5178";
    Contract5179: Report "5179";
    Contract5180: Report "5180";
    Contract5188: Report "5188";
    Contract5189: Report "5189";
    Contract5190: Report "5190";
    Contract5193: Report "5193";
    Contract5194: Report "5194";
    Contract5195: Report "5195";
    Contract5196: Report "5196";
    Contract5197: Report "5197";
    Contract5198: Report "5197";
    Contract5199: Report "5199";
    Contract5606: Report "5606";
    Contract5607: Report "5607";
    Contract5608: Report "5608";
    Contract5610: Report "5610";
    Contract5611: Report "5611";
    Contract5620: Report "5620";
    Contract5621: Report "5621";
    Contract5622: Report "5622";
    Contract5623: Report "5623";
    Contract5061: Report "5061";
    Contract5063: Report "5063";*/

    procedure CreateAttachment()
    var
        Attachment: Record "Attachment";
        InteractTmplLanguage: Record "Employee Contract Ledger";
        WordManagement: Codeunit "WordManagement";
        NewAttachNo: Integer;
    begin
        /*IF "Attachment No." <> 0 THEN BEGIN
          IF Attachment.GET("Attachment No.") THEN
            Attachment.TESTFIELD("Read Only",FALSE);
          IF NOT CONFIRM(Text001,FALSE) THEN
            EXIT;
        END;
        NewAttachNo := WordManagement.CreateWordAttachment("Employee No.",'BOS');
        IF NewAttachNo <> 0 THEN BEGIN
          IF "Attachment No." <> 0 THEN
            RemoveAttachment(FALSE);
          "Attachment No." := NewAttachNo;
          IF InteractTmplLanguage.GET("No.") THEN
            MODIFY
          ELSE
            INSERT;
        END ELSE*/


    end;

    procedure OpenAttachment()
    var
        Attachment: Record "Attachment";
    begin

        IF "Attachment No." = 0 THEN
            EXIT;
        Attachment.GET("Attachment No.");
        Attachment.OpenAttachment("Employee No.", FALSE, '');
    end;

    procedure CopyFromAttachment()
    var
        InteractTmplLanguage: Record "Interaction Tmpl. Language";
        Attachment: Record "Attachment";
        AttachmentManagement: Codeunit "AttachmentManagement";
        NewAttachNo: Integer;
    begin
        IF Attachment.GET("Attachment No.") THEN
            Attachment.TESTFIELD("Read Only", FALSE);

        IF "Attachment No." <> 0 THEN BEGIN
            IF NOT CONFIRM(Text004, FALSE) THEN
                EXIT;
            RemoveAttachment(FALSE);
            "Attachment No." := 0;
            MODIFY;
            COMMIT;
        END;


        NewAttachNo := AttachmentManagement.InsertAttachment("Attachment No.");
        IF NewAttachNo <> 0 THEN BEGIN
            "Attachment No." := NewAttachNo;
            MODIFY;
        END;
    end;

    procedure ImportAttachment()
    var
        Attachment: Record "Attachment";
    begin
        IF "Attachment No." <> 0 THEN BEGIN
            IF Attachment.GET("Attachment No.") THEN
                Attachment.TESTFIELD("Read Only", FALSE);

        END;

        CertCheck.RESET;
        CertCheck.SETFILTER("Employee No.", '%1', Rec."Employee No.");
        CertCheck.SETFILTER(Group, '%1', Rec.Group);
        IF CertCheck.FIND('-') THEN BEGIN
            BrojPotvrda := CertCheck.COUNT;
        END;
        IF Group = Group::Certification THEN BEGIN
            //ĐK  Attachment.SetParam1(Rec."Employee No.", 3, Rec.ID);
            hr.GET;
            IF Attachment.ImportAttachmentFromClientFile(hr."File Path" + "Employee No." + '-' + FORMAT(BrojPotvrda) + '.docx', FALSE, FALSE) THEN BEGIN
                "Attachment No." := Attachment."No.";
            END;
        END;
        IF Group = Group::Solutions THEN BEGIN
            //ĐK Attachment.SetParam1(Rec."Employee No.", 3, Rec.ID);
            hr.GET;
            IF Attachment.ImportAttachmentFromClientFile(hr."File Path" + "Employee No." + '-' + FORMAT(BrojPotvrda) + '.docx', FALSE, FALSE) THEN BEGIN
                "Attachment No." := Attachment."No.";
            END;
        END;
        IF Group = Group::Decisions THEN BEGIN
            //ĐK  Attachment.SetParam1(Rec."Employee No.", 3, Rec.ID);
            hr.GET;
            IF Attachment.ImportAttachmentFromClientFile(hr."File Path" + "Employee No." + '-' + FORMAT(BrojPotvrda) + '.docx', FALSE, FALSE) THEN BEGIN
                "Attachment No." := Attachment."No.";
            END;
        END;


        IF EXISTS(hr."File Path" + "Employee No." + '-' + FORMAT(BrojPotvrda) + '.docx') THEN
            ERASE(hr."File Path" + "Employee No." + '-' + FORMAT(BrojPotvrda) + '.docx');
    end;

    procedure ExportAttachment()
    var
        //   TempBlob: Record "TempBlob";
        MarketingSetup: Record "Marketing Setup";
        FileMgt: Codeunit "File Management";
        FileName: Text[1024];
        FileFilter: Text;
        ExportToFile: Text;
    begin
        MarketingSetup.GET;
        ExportToFile := '';
        IF AttachmentRecord.GET("Attachment No.") THEN
            WITH AttachmentRecord DO BEGIN
                IF "Storage Type" = "Storage Type"::Embedded THEN BEGIN
                    /*  CALCFIELDS(Attachment);
                      IF Attachment.HASVALUE THEN BEGIN
                          FileName := "Employee No." + '.' + "File Extension";
                          TempBlob.Blob := Attachment;
                          FileMgt.BLOBExport(TempBlob, FileName, TRUE);
                      END;*/
                END ELSE BEGIN
                    IF "Storage Type" = "Storage Type"::"Disk File" THEN BEGIN
                        IF MarketingSetup."Attachment Storage Type" = MarketingSetup."Attachment Storage Type"::"Disk File" THEN
                            MarketingSetup.TESTFIELD("Attachment Storage Location");
                        FileFilter := UPPERCASE("File Extension") + ' (*.' + "File Extension" + ')|*.' + "File Extension";
                    END;

                    ExportToFile := "Employee No." + '.' + "File Extension";
                    DOWNLOAD(ConstDiskFileName, Text005, '', FileFilter, ExportToFile);
                END;
            END;
    end;

    procedure RemoveAttachment(Prompt: Boolean)
    var
        Attachment: Record "Attachment";
    begin
        IF Attachment.GET("Attachment No.") THEN
            IF Attachment.RemoveAttachment(Prompt) THEN BEGIN
                "Attachment No." := 0;
                MODIFY;
            END;

    end;
}

