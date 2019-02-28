//
//  ViewController.swift
//  AVAudioPlayer播放音频
//
//  Created by 杨帆 on 2019/2/13.
//  Copyright © 2019 杨帆. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    //播放器
    var player:AVAudioPlayer?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //获取播放器
        player = self.getPlayer()
        
        setupBackMode()
        
    }
    

    //播放
    @IBAction func start(_ sender: Any) {
        
        player?.play()

    }
    
    //暂停
    @IBAction func pause(_ sender: Any) {
        
        player?.pause()
        
    }
    
    //停止
    @IBAction func stop(_ sender: Any) {
        
        player?.stop()
        
    }
    
    
    @IBAction func seekMusic(_ sender: UISlider) {
        
        
        let progress = sender.value
        
        
        player?.currentTime = Double(progress) * (player?.duration)!
        
        
    }
    
    
    func getPlayer() -> AVAudioPlayer?{
        
        //    1.初始化AVAudioPlayer对象，此时通常指定本地文件路径。
        //    2.设置播放器属性，例如重复次数、音量大小等。
        //    3.调用play方法播放。
        
        let path = Bundle.main.path(forResource: "ddz.mp3", ofType: nil)
        
        let url = URL (fileURLWithPath: path!)
        
        do {
        
            let player =  try AVAudioPlayer(contentsOf: url)
            
            //循环次数 0表示不循环
            player.numberOfLoops = 0
            
            //将音频文件加载到缓冲区
            player.prepareToPlay()
            
            //代理
            player.delegate = self
            
            return player
        }
        
        catch {
            
            return nil
        }
        
    }
    
    //后台播放设置
    func setupBackMode(){
        
        //在iOS中每个应用都有一个音频会话，这个会话就通过AVAudioSession来表示
        let session = AVAudioSession()
        
        do {
            
            //设置后台播放模式
            try session.setCategory(.playback, mode: .default, options: .allowBluetooth)
            
            //设置完音频会话类型之后需要调用setActive::方法将会话激活才能起作用
            try session.setActive(true, options: .notifyOthersOnDeactivation)
            
        }
            
        catch{
            
            print(error)
        }
    }
    
}

extension ViewController : AVAudioPlayerDelegate {
    
    //播放完
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {

        print("播放完毕")
        
    }
    
}
