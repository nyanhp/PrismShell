function Show-PrismThumbnail
{
    param
    (
        [string]
        $Path
    )

    if ($IsLinux -or $IsMacOs)
    {
        Stop-PSFFunction -String 'ShowPrismThumbnail.WindowsOnly'
    }

    Add-Type -Assembly System.Windows.Forms

    $thumbnail = [System.Drawing.Image]::Fromfile($Path)
    $form = [Windows.Forms.Form]::new()
    $form.Text = 'Prism status'
    $form.SizeGripStyle = [System.Windows.Forms.SizeGripStyle]::Hide
    $form.Width = $thumbnail.Size.Width
    $form.Height = $thumbnail.Size.Height
    $pictureBox = [Windows.Forms.PictureBox]::new()
    $pictureBox.Width = $thumbnail.Size.Width
    $pictureBox.Height = $thumbnail.Size.Height
    $pictureBox.Image = $thumbnail
    $form.Controls.add($pictureBox)
    $form.Show()
}
